#include "stdint.h"
#include "string.h"

#define PORT_CONTROL0  (0)
#define PORT_CONTROL1  (1)
#define INPUT_STATUS   (2)
#define OUTPUT_CONTROL (3)
#define BIT_OPERATE    (4)
#define BIT_CLEAR      (5)

#define RCU_APB2EN     (6)

extern uint32_t _sidata, _sdata, _edata, _sbss, _ebss;

volatile uint32_t* GPIOB_BASE = (volatile uint32_t*)(0x40010C00);
volatile uint32_t* RCU_BASE = (volatile uint32_t*)(0x40021000);

void initialize_ram(){
    memcpy(&_sdata, &_sidata, ((void*)&_edata - (void*)&_sdata));
    memset(&_sbss, 0x00, (( void*)&_ebss - (void*)&_sbss));
}

//This project includes support for initialized memory in RAM
//All in all ~75 instructions

int main(){
    initialize_ram(); //This part usually happens before we call main

    RCU_BASE[RCU_APB2EN] |= (1U << 3);
    GPIOB_BASE[PORT_CONTROL0] = (GPIOB_BASE[PORT_CONTROL0] & (0xFFFFFFF0)) | 0x3;

    while(1){
        for(volatile int i = 0; i < 500000; i++);
        GPIOB_BASE[OUTPUT_CONTROL] ^= 1;
    }
}