OUTPUT_ARCH( "riscv" )
ENTRY( _start )

MEMORY
{
    flash (rxai!w) : ORIGIN = 0x08000000, LENGTH = 128K
    ram (wxa!ri) : ORIGIN = 0x20000000, LENGTH = 32K
}

SECTIONS
{
    .init :
    {
        KEEP (*(SORT_NONE(.init)))
    } > flash AT > flash
    .text :
    {
        *(.text)
        *(.rodata .rodata.*)  
        *(.srodata .srodata.*)
    } > flash AT > flash

    .data :
    {
        *(.rdata) 
        *(.data .data.*)
        *(.sdata .sdata.*)
    } > ram

    .bss :
    {
        *(.sbss*)
        *(.bss .bss.*)
        *(COMMON)
    } > ram

    .stack ORIGIN(ram) + LENGTH(ram) :
    {
        PROVIDE(_sp = .);
    } > ram
}