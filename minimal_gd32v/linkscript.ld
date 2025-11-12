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
    . = ALIGN(4);

    _sidata = .;

    .data : AT ( _sidata )
    {
        _sdata = .;
        *(.rdata) 
        *(.data .data.*)
        *(.sdata .sdata.*)
        . = ALIGN(4);
        _edata = .;
    } > ram

    .bss :
    {
        _sbss = .;
        *(.sbss*)
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > ram

    .stack ORIGIN(ram) + LENGTH(ram) :
    {
        PROVIDE(_sp = .);
    } > ram
}