#include "stdint.h"

#define PORT_CONTROL0  (0)
#define OUTPUT_CONTROL (3)

#define RCU_APB2EN     (6)

//Full project is ~34 instructions total and blinks B0 at ~1Hz
int main(){
    volatile uint32_t* const GPIOB_BASE = (volatile uint32_t*)(0x40010C00);
    volatile uint32_t* const RCU_BASE = (volatile uint32_t*)(0x40021000);

    RCU_BASE[RCU_APB2EN] |= (1U << 3);
    GPIOB_BASE[PORT_CONTROL0] = (GPIOB_BASE[PORT_CONTROL0] & (0xFFFFFFF0)) | 0x3;

    while(1){
        for(volatile int i = 0; i < 500000; i++);
        GPIOB_BASE[OUTPUT_CONTROL] ^= 1;
    }
}