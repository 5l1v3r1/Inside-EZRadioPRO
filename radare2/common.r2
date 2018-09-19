# configure r2

echo configuring r2 for Si4x6x rev C2A

e asm.cpu=8051-shared-code-xdata
e cfg.bigendian = true
e asm.jmpsub=true
e asm.shortcut=0

# macro for manual function declaration
"(fcn start end name,f $2=$0; afu $1 @ $0)"

# setup memory map

echo setting up memory map
aei
omf 4 rwx
ar _idata=_xdata+0x5400
ar _pdata=0x50
aei
om- 3
Cd 1 0x80 @_sfr+0x80
Cd 1 0x100 @_idata
Cd 1 0x100 @_pdata*0x100

# general 8051 

f sfr.sp 1 @ _sfr+0x81
f sfr.dl 1 @ _sfr+0x82
f sfr.dh 1 @ _sfr+0x83
f sfr.pcon 1 @ _sfr+0x87
f sfr.ie 1 @ _sfr+0xa8
f sfr.ip 1 @ _sfr+0xb8
f sfr.psw 1 @ _sfr+0xd0
f sfr.acc 1 @ _sfr+0xe0
f sfr.b 1 @ _sfr+0xf0

echo annotating 8051 stuff
/c clr ie.7 > /dev/null
CCu disable interrupts @@hit*
f-hit*

/c setb ie.7 > /dev/null
CCu enable interrupts @@hit*
f-hit*

/c mov sp > /dev/null
CCu setup stack @@hit*
f-hit*

/c psw.7 > /dev/null
CCu carry @@hit*
f-hit*
