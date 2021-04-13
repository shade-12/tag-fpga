/*
 * run_nn.c
 *
 *  Created on: Mar 3, 2021
 *      Author: Shade Wong
 */

#include <stdio.h>
#include "../hps_soc_system.h"

#define L1_IN  1400
#define L1_OUT 900
#define L2_IN L1_OUT
#define L2_OUT 900
#define L3_IN L2_OUT
#define L3_OUT 900
#define L4_IN L3_OUT
#define L4_OUT 2
#define NPARAMS (L1_OUT + L1_IN * L1_OUT + L2_OUT + L2_IN * L2_OUT + L3_OUT + L3_IN * L3_OUT + L4_OUT + L4_IN * L4_OUT)

volatile unsigned *dnn_acc = (volatile unsigned *) 0xFF200000; /* DNN accelerator */

volatile int *nn      = (volatile int *) 0x0A000000; /* neural network biases and weights */
volatile int *input   = (volatile int *) 0x0A800000; /* input image */
volatile int *l1_acts = (volatile int *) 0x0A802000; /* activations of layer 1 */
volatile int *l2_acts = (volatile int *) 0x0A803000; /* activations of layer 2 */
volatile int *l3_acts = (volatile int *) 0x0A804000; /* activations of layer 3 */
volatile int *l4_acts = (volatile int *) 0x0A805000; /* activations of layer 4 (output) */

// Set to 1 to use hardware accelerator, 0 to use software
#define USE_HW 1


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

int run_nn() {

    volatile int *l1_b = nn;                    /* layer 1 bias */
    volatile int *l1_w = l1_b + L1_OUT;         /* layer 1 weights */
    volatile int *l2_b = l1_w + L1_IN * L1_OUT; /* layer 2 bias */
    volatile int *l2_w = l2_b + L2_OUT;         /* layer 2 weights */
    volatile int *l3_b = l2_w + L2_IN * L2_OUT; /* layer 3 bias */
    volatile int *l3_w = l3_b + L3_OUT;         /* layer 3 weights */
    volatile int *l4_b = l3_w + L3_IN * L3_OUT;
    volatile int *l4_w = l4_b + L4_OUT;

    apply_layer(L1_IN, L1_OUT, l1_b, l1_w, 1, input, l1_acts);
    apply_layer(L2_IN, L2_OUT, l2_b, l2_w, 1, l1_acts, l2_acts);
    apply_layer(L3_IN, L3_OUT, l3_b, l3_w, 1, l2_acts, l3_acts);
    apply_layer(L4_IN, L4_OUT, l3_b, l3_w, 0, l3_acts, l4_acts);

    int result = max_index(L4_OUT, l4_acts);
    printf("Predicted result: %d\n", result); // 0 means no human , 1 means human

    return 0;
}