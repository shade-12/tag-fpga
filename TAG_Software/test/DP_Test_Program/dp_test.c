#include <stdio.h>
#define dp_accelerator_base (volatile int *) 0xFF202040

int main()
{
    int v = 0x05; // arbitrary value

    *dp_accelerator_base = v;  // write the value to component
    printf("value is now %x\n", *(dp_accelerator_base + 1));

    // increment what is in the component   
    *(dp_accelerator_base+1) = 0;  // does not matter what you write
    printf("value is now %x\n", *(dp_accelerator_base + 1));
    
    // increment it again
    *(dp_accelerator_base+1) = 0;  // does not matter what you write
    printf("value is now %x\n", *(dp_accelerator_base + 1));
    
    // get the value in reverse bit order
    printf("reverse bit order %x\n", *(dp_accelerator_base));
    
    // get the complement of the value
    printf("complement is %x\n", *(dp_accelerator_base + 2));
    
    return(0);
}