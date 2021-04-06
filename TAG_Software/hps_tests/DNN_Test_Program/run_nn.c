// Adapted from CPEN 391 Lab 4 assignment

#include <stdio.h>

#define L1_IN  784
#define L1_OUT 1000
#define L2_IN L1_OUT
#define L2_OUT 1000
#define L3_IN L2_OUT
#define L3_OUT 10
#define NPARAMS (L1_OUT + L1_IN * L1_OUT + L2_OUT + L2_IN * L2_OUT + L3_OUT + L3_IN * L3_OUT)

volatile unsigned *hex = (volatile unsigned *) 0xFF200030; /* hex display PIO */
volatile unsigned *dnn_acc = (volatile unsigned *) 0xFF202040; /* DNN accelerator */

/* normally these would be contiguous but it's nice to know where they are for debugging */
volatile int *nn      = (volatile int *) 0x01000000; /* neural network biases and weights */
volatile int *input   = (volatile int *) 0x01800000; /* input image */
volatile int *l1_acts = (volatile int *) 0x01801000; /* activations of layer 1 */
volatile int *l2_acts = (volatile int *) 0x01802000; /* activations of layer 2 */
volatile int *l3_acts = (volatile int *) 0x01803000; /* activations of layer 3 (outputs) */

// Set to 1 to use hardware accelerator, 0 to use software
#define USE_HW 1


int hex7seg(unsigned d) {
    return (d < 10) ? d : 0x3f;
}

// use software to compute the dot product of w[i]*ifmap[i]
int dotprod_sw(int n_in, volatile int *w, volatile int *ifmap)
{
    int sum = 0;
    unsigned i = 0;
    while (i < n_in) { /* Q16 dot product */
        sum += (int) (((long long) w[i] * (long long) ifmap[i]) >> 16);
        ++i;
    }
    return sum;
}

// use accelerator hardware to compute the dot product of w[i]*ifmap[i]
int dotprod_hw(int n_in, volatile int *w, volatile int *ifmap)
{
    // computes using hardware
    *(dnn_acc + 2) = (unsigned) w;
    *(dnn_acc + 3) = (unsigned) ifmap;
    *(dnn_acc + 5) = (unsigned) n_in;
    *dnn_acc = 0; /* start */
    return *dnn_acc; /* make sure the accelerator is finished */
}

/* use our DNN accelerator to apply fully-connected layer */
void apply_layer(int n_in, int n_out, volatile int *b, volatile int *w, int use_relu, volatile int *ifmap, volatile int *ofmap) {
    unsigned o = 0, wo = 0;
    while (o < n_out) {
        int sum = b[o]; /* bias for the current output index */
        #if (USE_HW)
            sum += dotprod_hw( n_in, &w[wo], ifmap );
        #else
            sum += dotprod_sw( n_in, &w[wo], ifmap );
        #endif
        if (use_relu) sum = (sum < 0) ? 0 : sum; /* ReLU activation */
        ofmap[o] = sum;
        ++o;
        wo += n_in;
    }
}

int max_index(int n_in, volatile int *ifmap) {
    int max_sofar = 0;
    int i = 1;
    while (i < n_in) {
        if (ifmap[i] > ifmap[max_sofar]) max_sofar = i;
        ++i;
    }
    return max_sofar;
}

int main() {
    *hex = 0x3f; /* display - */

    volatile int *l1_b = nn;                    /* layer 1 bias */
    volatile int *l1_w = l1_b + L1_OUT;         /* layer 1 weights */
    volatile int *l2_b = l1_w + L1_IN * L1_OUT; /* layer 2 bias */
    volatile int *l2_w = l2_b + L2_OUT;         /* layer 2 weights */
    volatile int *l3_b = l2_w + L2_IN * L2_OUT; /* layer 3 bias */
    volatile int *l3_w = l3_b + L3_OUT;         /* layer 3 weights */

    apply_layer(L1_IN, L1_OUT, l1_b, l1_w, 1, input, l1_acts);
    apply_layer(L2_IN, L2_OUT, l2_b, l2_w, 1, l1_acts, l2_acts);
    apply_layer(L3_IN, L3_OUT, l3_b, l3_w, 0, l2_acts, l3_acts);

    int result = max_index(L3_OUT, l3_acts);
    printf("Predicted digit: %d\n", result);
    *hex = hex7seg(result);
    return 0;
}