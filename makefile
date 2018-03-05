FILE=gamehut

emu: ${FILE}.bin
	wine ./Emulator/gens_kmod/gens.exe "$$(pwd)/bin/${FILE}.bin"

${FILE}.bin: ./src/${FILE}.s
	cd src && \
	wine ../Assembler/asm68k /p /i /w /ov+ /oos+ /oop+ /oow+ /ooz+ /ooaq+ /oosq+ /oomq+ /ow+ ${FILE}.s,../bin/${FILE}.bin,../bin/${FILE}

all: ${FILE}

clean:
	rm ./bin/*
