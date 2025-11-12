CC = riscv32-unknown-elf-gcc
OBJCPY = riscv32-unknown-elf-objcopy

ASFLAGS += -c
ASFLAGS += -Os
ASFLAGS += -Wall
ASFLAGS += -march=rv32imac_zicsr
ASFLAGS += -mabi=ilp32
ASFLAGS += -mcmodel=medlow

CFLAGS += -c
CFLAGS += -Os
CFLAGS += -Wall
CFLAGS += --specs=nano.specs
CFLAGS += -march=rv32imac_zicsr
CFLAGS += -mabi=ilp32
CFLAGS += -mcmodel=medlow

LDFLAGS += -Wall
LDFLAGS += -Wl,--gc-sections
LDFLAGS += -nostdlib
LDFLAGS += -Os
LDFLAGS += -lc
LDFLAGS += -lgcc
LDFLAGS += --specs=nano.specs
LDFLAGS += -Tlinkscript.ld
LDFLAGS += -march=rv32imac_zicsr
LDFLAGS += -mabi=ilp32
LDFLAGS += -mcmodel=medlow

INCLUDE = -I./

ASSEMBLY = init.S
CFILES = main.c

OBJECTS  = $(ASSEMBLY:.S=.o)
OBJECTS += $(CFILES:.c=.o)

.PHONY: all clean dfu
all: firmware.bin

clean:
	rm main.o
	rm init.o
	rm firmware.elf
	rm firmware.bin

%.o: %.S
	$(CC) -x assembler-with-cpp $(ASFLAGS) $(INCLUDE) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDE) $< -o $@

firmware.elf: $(OBJECTS)
	$(CC) $^ $(LDFLAGS) -o $@

firmware.bin: firmware.elf
	$(OBJCPY) -S -O binary $< $@

dfu: all
	-dfu-suffix -v 0x28e9 -p 0x0189 -d 0xffff -a firmware.bin
	dfu-util -d 28e9:0189 -a 0 --dfuse-address 0x08000000:leave -D firmware.bin