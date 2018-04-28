FILE=gamehut

emu: ${FILE}.bin
	wine ./Emulator/gens_kmod/gens.exe "$$(pwd)/bin/${FILE}.bin"

${FILE}.bin: ./src/${FILE}.s
	cd src && \
    #p    Produce pure binary output file
	#i    Show an information window while assembling. Only compatible with pure 16-bit MSDOS.
	#w    Write all equates to the listing file.
	#v+   Write local labels to symbol file
	#os+  Short branch optimisation
	#op+  PC relative optimisation
	#ow+  Print warnings
	#oz+  Zero offset optimisation
	#oaq+ Addq optimisation
	#osq+ Subq optimisation
	#omq+ Moveq optimisation
	#ow+  Absolute word addressing optimisation
	wine ../Assembler/asm68k /p /i /w /ov+ /oos+ /oop+ /oow+ /ooz+ /ooaq+ /oosq+ /oomq+ /ow+ ${FILE}.s,../bin/${FILE}.bin,../bin/${FILE}

debug: ./src/${FILE}.s
	cd src && \
	wine ../Assembler/asm68k /i /w /ov+ /oos+ /oop+ /oow+ /ooz+ /ooaq+ /oosq+ /oomq+ /ow+ ${FILE}.s,../bin/${FILE}.db.bin,../bin/${FILE}.db

debugMame: debug
	mame genesis -debug -cart ./bin/${FILE}.db.bin

all: ${FILE}

clean:
	rm ./bin/*
