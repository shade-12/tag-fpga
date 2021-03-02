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
volatile int *nn      = (volatile int *) 0x0a000000; /* neural network biases and weights */
volatile int *input   = (volatile int *) 0x0a800000; /* input image */
volatile int *l1_acts = (volatile int *) 0x0a801000; /* activations of layer 1 */
volatile int *l2_acts = (volatile int *) 0x0a802000; /* activations of layer 2 */
volatile int *l3_acts = (volatile int *) 0x0a803000; /* activations of layer 3 (outputs) */

int hex7seg(unsigned d) {
    const unsigned digits[] = { 0x40,  0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x10 };
    return (d < 10) ? digits[d] : 0x3f;
}

/* apply fully-connected layer: matrix-vector multiplication w/ optional ReLU activation */
void apply_layer(int n_in, int n_out, volatile int *b, volatile int *w, int use_relu, volatile int *ifmap, volatile int *ofmap) {
    unsigned o = 0, wo = 0;
    while (o < n_out) {
        int sum = b[o]; /* bias for the current output index */
        unsigned i = 0;
        while (i < n_in) { /* Q16 dot product */
            sum += (int) (((long long) w[wo + i] * (long long) ifmap[i]) >> 16);
            ++i;
        }
        if (use_relu) sum = (sum < 0) ? 0 : sum; /* ReLU activation */
        ofmap[o] = sum;
        ++o;
        wo += n_in;
    }
}

/* use our DNN accelerator to apply fully-connected layer */
void apply_layer_acc(int n_in, int n_out, volatile int *b, volatile int *w, int use_relu, volatile int *ifmap, volatile int *ofmap) {
    *(dnn_acc + 3) = (unsigned) ifmap;
    *(dnn_acc + 5) = (unsigned) n_in;
    *(dnn_acc + 7) = (unsigned) use_relu;
    unsigned o = 0, wo = 0;
    while (o < n_out) {
        *(dnn_acc + 1) = (unsigned) (b + o);
        *(dnn_acc + 2) = (unsigned) (w + wo);
        *(dnn_acc + 4) = (unsigned) (ofmap + o);
        *dnn_acc = 0; /* start */
        ++o;
        wo += n_in;
    }
    *dnn_acc; /* make sure the accelerator is finished */
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

void main() {
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
    /*
    apply_layer_acc(L1_IN, L1_OUT, l1_b, l1_w, 1, input, l1_acts);
    apply_layer_acc(L2_IN, L2_OUT, l2_b, l2_w, 1, l1_acts, l2_acts);
    apply_layer_acc(L3_IN, L3_OUT, l3_b, l3_w, 0, l2_acts, l3_acts);
    */
    int result = max_index(L3_OUT, l3_acts);
    printf("Predicted digit: %d\n", result);
    *hex = hex7seg(result);
    return;
}