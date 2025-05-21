*version 9.1 507517992
u 158
R? 10
D? 5
U? 5
V? 2
@libraries
@analysis
@targets
@attributes
@translators
a 0 u 13 0 0 0 hln 100 PCBOARDS=PCB
a 0 u 13 0 0 0 hln 100 PSPICE=PSPICE
a 0 u 13 0 0 0 hln 100 XILINX=XILINX
@setup
unconnectedPins 0
connectViaLabel 0
connectViaLocalLabels 0
NoStim4ExtIFPortsWarnings 1
AutoGenStim4ExtIFPorts 1
@index
pageloc 1 0 7859 
@status
c 121:11:12:21:18:18;1639325898
n 0 121:11:12:21:18:23;1639325903 e 
s 2832 121:11:12:21:18:26;1639325906 e 
*page 1 0 970 720 iA
@ports
port 129 GND_EARTH 630 400 h
port 130 GND_EARTH 460 430 h
port 131 GND_EARTH 490 330 u
port 132 GND_EARTH 480 240 u
port 133 GND_EARTH 480 160 u
port 134 BUBBLE 500 260 h
a 1 x 3 0 20 10 hcn 100 LABEL=6v
port 135 BUBBLE 510 180 h
a 1 x 3 0 25 10 hcn 100 LABEL=6v
port 136 BUBBLE 500 350 h
a 1 x 3 0 20 10 hcn 100 LABEL=12v
port 137 GND_EARTH 320 420 h
port 141 BUBBLE 400 80 h
a 1 x 3 0 0 0 hcn 100 LABEL=6V
port 144 GND_EARTH 720 240 h
port 146 BUBBLE 720 180 h
a 1 x 3 0 0 0 hcn 100 LABEL=Vin
port 151 BUBBLE 340 100 h
a 1 x 3 0 0 0 hcn 100 LABEL=Vin
port 138 BUBBLE 510 90 h
a 1 x 3 0 0 0 hcn 100 LABEL=6V
@parts
part 112 r 400 300 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 10 10 hln 100 VALUE=820
a 0 a 0:13 0 0 0 hln 100 PKGREF=R1
a 0 ap 9 0 20 10 hln 100 REFDES=R1
part 113 r 400 210 v
a 0 u 13 0 5 5 hln 100 VALUE=820
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 ap 9 0 15 0 hln 100 REFDES=R2
part 115 r 400 400 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 15 30 hln 100 VALUE=820
a 0 a 0:13 0 0 0 hln 100 PKGREF=R4
a 0 ap 9 0 15 0 hln 100 REFDES=R4
part 116 r 520 130 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R5
a 0 ap 9 0 15 0 hln 100 REFDES=R5
part 117 Dbreak 580 130 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=D1
a 0 ap 9 0 15 0 hln 100 REFDES=D1
part 118 Dbreak 570 390 h
a 0 ap 9 0 15 0 hln 100 REFDES=D2
a 0 a 0:13 0 0 0 hln 100 PKGREF=D2
part 119 Dbreak 570 300 h
a 0 ap 9 0 15 0 hln 100 REFDES=D3
a 0 a 0:13 0 0 0 hln 100 PKGREF=D3
part 120 Dbreak 570 210 h
a 0 a 0:13 0 0 0 hln 100 PKGREF=D4
a 0 ap 9 0 15 0 hln 100 REFDES=D4
part 121 r 520 210 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R6
a 0 ap 9 0 15 0 hln 100 REFDES=R6
part 122 LM324 420 190 h
a 0 sp 11 0 14 70 hcn 100 PART=LM324
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=DIP14
a 0 s 0:13 0 0 0 hln 100 GATE=A
a 0 a 0:13 0 0 0 hln 100 PKGREF=U1
a 0 ap 9 0 56 8 hcn 100 REFDES=U1A
part 123 LM324 420 110 h
a 0 sp 11 0 14 70 hcn 100 PART=LM324
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=DIP14
a 0 s 0:13 0 0 0 hln 100 GATE=A
a 0 a 0:13 0 0 0 hln 100 PKGREF=U2
a 0 ap 9 0 56 8 hcn 100 REFDES=U2A
part 124 r 520 390 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R7
a 0 ap 9 0 15 0 hln 100 REFDES=R7
part 125 LM324 420 370 h
a 0 sp 11 0 14 70 hcn 100 PART=LM324
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=DIP14
a 0 s 0:13 0 0 0 hln 100 GATE=A
a 0 a 0:13 0 0 0 hln 100 PKGREF=U3
a 0 ap 9 0 56 8 hcn 100 REFDES=U3A
part 126 r 510 300 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R8
a 0 ap 9 0 15 0 hln 100 REFDES=R8
part 127 LM324 420 280 h
a 0 sp 11 0 14 70 hcn 100 PART=LM324
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=DIP14
a 0 s 0:13 0 0 0 hln 100 GATE=A
a 0 a 0:13 0 0 0 hln 100 PKGREF=U4
a 0 ap 9 0 56 8 hcn 100 REFDES=U4A
part 128 r 370 410 u
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 u 13 0 30 25 hln 100 VALUE=2.7k
a 0 a 0:13 0 0 0 hln 100 PKGREF=R9
a 0 ap 9 0 35 5 hln 100 REFDES=R9
part 145 VDC 720 190 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V1
a 1 ap 9 0 24 7 hcn 100 REFDES=V1
a 1 u 13 0 -11 18 hcn 100 DC=6.002V
part 114 r 400 130 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R3
a 0 ap 9 0 15 0 hln 100 REFDES=R3
a 0 u 13 0 5 0 hln 100 VALUE=270
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
@conn
w 3
s 420 230 400 230 2
s 400 230 400 210 4
s 400 260 400 230 6
a 0 up 33 0 402 245 hlt 100 V=
w 15
s 520 210 500 210 14
w 17
s 520 130 500 130 16
w 19
s 420 320 400 320 18
s 400 320 400 300 20
s 400 320 400 360 22
a 0 up 33 0 402 340 hlt 100 V=
w 25
s 370 410 400 410 26
a 0 up 33 0 385 409 hct 100 V=
s 400 410 420 410 30
s 400 400 400 410 28
w 32
s 570 390 560 390 31
w 34
s 570 300 550 300 33
w 36
s 580 130 560 130 35
w 38
s 630 130 610 130 37
s 630 390 600 390 41
s 630 300 630 390 43
s 600 300 630 300 45
s 630 130 630 210 47
a 0 up 33 0 632 255 hlt 100 V=
s 630 210 630 300 51
s 600 210 630 210 49
s 630 400 630 390 52
w 55
s 500 350 460 350 54
a 0 up 33 0 480 349 hct 100 V=
s 460 350 460 360 56
w 59
s 460 420 460 430 58
a 0 up 33 0 462 425 hlt 100 V=
w 61
s 490 330 460 330 60
a 0 up 33 0 475 329 hct 100 V=
w 63
s 500 260 460 260 62
a 0 up 33 0 480 259 hct 100 V=
s 460 260 460 270 64
w 67
s 480 240 480 250 66
s 480 250 460 250 68
a 0 up 33 0 470 249 hct 100 V=
s 460 250 460 240 70
w 73
s 510 180 490 180 72
s 490 180 490 170 74
s 490 170 460 170 76
a 0 up 33 0 475 169 hct 100 V=
s 460 170 460 180 78
w 81
s 480 160 460 160 80
a 0 up 33 0 470 159 hct 100 V=
w 87
s 570 210 560 210 86
w 89
s 520 390 500 390 88
w 91
s 500 300 510 300 90
w 93
s 330 410 320 410 92
s 320 410 320 420 94
a 0 up 33 0 322 415 hlt 100 V=
w 97
s 420 110 410 110 98
s 410 190 410 110 104
s 420 190 410 190 102
s 410 370 410 280 105
s 410 280 410 190 109
s 420 280 410 280 107
s 420 370 410 370 110
w 83
s 460 90 460 100 84
s 510 90 460 90 139
a 0 up 33 0 480 89 hct 100 V=
w 143
s 400 80 400 90 142
w 148
s 720 180 720 190 147
w 150
s 720 240 720 230 149
w 9
s 420 150 400 150 8
s 400 150 400 130 10
s 400 150 400 170 12
s 340 130 340 100 154
s 340 130 400 130 156
@junction
j 400 230
+ w 3
+ w 3
j 400 150
+ w 9
+ w 9
j 400 320
+ w 19
+ w 19
j 400 410
+ w 25
+ w 25
j 630 300
+ w 38
+ w 38
j 630 210
+ w 38
+ w 38
j 630 390
+ w 38
+ w 38
j 410 190
+ w 97
+ w 97
j 410 280
+ w 97
+ w 97
j 400 260
+ p 112 2
+ w 3
j 400 300
+ p 112 1
+ w 19
j 400 210
+ p 113 1
+ w 3
j 400 170
+ p 113 2
+ w 9
j 400 130
+ p 114 1
+ w 9
j 400 360
+ p 115 2
+ w 19
j 400 400
+ p 115 1
+ w 25
j 520 130
+ p 116 1
+ w 17
j 560 130
+ p 116 2
+ w 36
j 580 130
+ p 117 1
+ w 36
j 610 130
+ p 117 2
+ w 38
j 570 390
+ p 118 1
+ w 32
j 600 390
+ p 118 2
+ w 38
j 570 300
+ p 119 1
+ w 34
j 600 300
+ p 119 2
+ w 38
j 600 210
+ p 120 2
+ w 38
j 570 210
+ p 120 1
+ w 87
j 520 210
+ p 121 1
+ w 15
j 560 210
+ p 121 2
+ w 87
j 420 230
+ p 122 -
+ w 3
j 500 210
+ p 122 OUT
+ w 15
j 460 240
+ p 122 V-
+ w 67
j 460 180
+ p 122 V+
+ w 73
j 420 190
+ p 122 +
+ w 97
j 420 150
+ p 123 -
+ w 9
j 500 130
+ p 123 OUT
+ w 17
j 460 160
+ p 123 V-
+ w 81
j 460 100
+ p 123 V+
+ w 83
j 420 110
+ p 123 +
+ w 97
j 560 390
+ p 124 2
+ w 32
j 520 390
+ p 124 1
+ w 89
j 420 410
+ p 125 -
+ w 25
j 460 360
+ p 125 V+
+ w 55
j 460 420
+ p 125 V-
+ w 59
j 500 390
+ p 125 OUT
+ w 89
j 420 370
+ p 125 +
+ w 97
j 550 300
+ p 126 2
+ w 34
j 510 300
+ p 126 1
+ w 91
j 420 320
+ p 127 -
+ w 19
j 460 330
+ p 127 V-
+ w 61
j 460 270
+ p 127 V+
+ w 63
j 500 300
+ p 127 OUT
+ w 91
j 420 280
+ p 127 +
+ w 97
j 370 410
+ p 128 1
+ w 25
j 330 410
+ p 128 2
+ w 93
j 630 400
+ s 129
+ w 38
j 460 430
+ s 130
+ w 59
j 490 330
+ s 131
+ w 61
j 480 240
+ s 132
+ w 67
j 480 160
+ s 133
+ w 81
j 500 260
+ s 134
+ w 63
j 510 180
+ s 135
+ w 73
j 500 350
+ s 136
+ w 55
j 320 420
+ s 137
+ w 93
j 510 90
+ s 138
+ w 83
j 400 90
+ p 114 2
+ w 143
j 400 80
+ s 141
+ w 143
j 720 190
+ p 145 +
+ w 148
j 720 180
+ s 146
+ w 148
j 720 230
+ p 145 -
+ w 150
j 720 240
+ s 144
+ w 150
j 340 100
+ s 151
+ w 9
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
