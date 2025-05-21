*version 9.1 43068107
u 492
U? 4
R? 14
V? 25
Q? 3
D? 4
? 10
TX? 3
@libraries
@analysis
.AC 0 1 0
+0 101
+1 10
+2 1.00K
.DC 0 0 0 0 1 1
.TRAN 1 0 0 0
+0 0ms
+1 6s
+3 6ms
.OP 1 
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
pageloc 1 0 8161 
@status
n 0 122:00:04:01:26:15;1641241575 e 
s 0 122:00:04:01:26:16;1641241576 e 
*page 1 0 970 720 iA
@ports
port 153 BUBBLE 170 160 h
a 1 x 3 0 20 5 hcn 100 LABEL=12v
port 154 BUBBLE 350 180 h
a 1 x 3 0 0 5 hcn 100 LABEL=12v
port 315 GND_EARTH 170 240 h
port 22 GND_EARTH 220 340 h
port 50 BUBBLE 370 340 d
a 1 x 3 0 0 10 hcn 100 LABEL=12v
port 41 GND_EARTH 250 340 d
port 314 GND_EARTH 350 260 h
port 8 BUBBLE 20 320 h
a 1 x 3 0 10 0 hcn 100 LABEL=12v
port 9 GND_EARTH 20 360 h
port 178 GND_EARTH 50 360 h
port 177 BUBBLE 50 320 h
a 1 x 3 0 10 0 hcn 100 LABEL=Vout
port 190 GND_EARTH 90 360 h
port 189 BUBBLE 90 320 h
a 1 x 3 0 10 0 hcn 100 LABEL=-12v
port 135 BUBBLE 510 320 u
a 1 x 3 0 0 10 hcn 100 LABEL=12v
port 147 GND_EARTH 580 250 h
port 489 BUBBLE 60 200 u
a 1 x 3 0 0 0 hcn 100 LABEL=Vout
@parts
part 67 r 360 150 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R8
a 0 ap 9 0 15 0 hln 100 REFDES=R8
a 0 u 13 0 15 25 hln 100 VALUE=30k
part 15 r 220 330 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R3
a 0 ap 9 0 15 0 hln 100 REFDES=R3
a 0 u 13 0 5 25 hln 100 VALUE=10k
part 14 r 220 270 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R2
a 0 ap 9 0 15 0 hln 100 REFDES=R2
a 0 u 13 0 5 0 hln 100 VALUE=260k
part 62 r 250 200 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R7
a 0 ap 9 0 15 0 hln 100 REFDES=R7
a 0 u 13 0 15 25 hln 100 VALUE=40k
part 34 r 300 300 d
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R6
a 0 ap 9 0 5 25 hln 100 REFDES=R6
a 0 u 13 0 15 35 hln 100 VALUE=100k
part 32 r 250 340 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R4
a 0 ap 9 0 15 0 hln 100 REFDES=R4
a 0 u 13 0 15 25 hln 100 VALUE=10k
part 3 uA741 310 200 h
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=DIP8
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=U2
a 0 ap 9 0 14 0 hln 100 REFDES=U2
a 0 sp 11 0 10 70 hcn 100 PART=uA741
part 7 VDC 20 320 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V2
a 1 ap 9 0 24 7 hcn 100 REFDES=V2
a 1 u 13 0 -1 33 hcn 100 DC=12V
part 191 VDC 90 320 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V5
a 1 ap 9 0 24 7 hcn 100 REFDES=V5
a 1 u 13 0 24 33 hcn 100 DC=-12V
part 120 r 490 290 v
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R10
a 0 ap 9 0 15 0 hln 100 REFDES=R10
a 0 u 13 0 5 0 hln 100 VALUE=2.2k
part 139 r 570 200 u
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R11
a 0 ap 9 0 15 0 hln 100 REFDES=R11
a 0 u 13 0 15 30 hln 100 VALUE=680
part 119 Q2N2907A 500 220 h
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=TO-18
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=Q2
a 0 ap 9 0 5 5 hln 100 REFDES=Q2
a 0 sp 11 0 15 25 hln 100 PART=Q2N2907A
part 215 D1N4002 580 210 d
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=DO-41
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=D3
a 0 ap 9 0 17 4 hln 100 REFDES=D3
a 0 sp 11 0 27 -1 hln 100 PART=D1N4002
part 115 r 440 220 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R9
a 0 ap 9 0 15 0 hln 100 REFDES=R9
a 0 u 13 0 15 25 hln 100 VALUE=10k
part 33 r 320 340 h
a 0 sp 0 0 0 10 hlb 100 PART=r
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=RC05
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=R5
a 0 ap 9 0 15 0 hln 100 REFDES=R5
a 0 u 13 0 35 25 hln 100 VALUE=26.35k
part 309 VDC 50 320 h
a 0 sp 0 0 22 37 hln 100 PART=VDC
a 0 a 0:13 0 0 0 hln 100 PKGREF=V18
a 1 ap 9 0 24 7 hcn 100 REFDES=V18
a 1 u 13 0 29 33 hcn 100 DC=280mV
part 2 uA741 130 180 h
a 0 sp 11 0 0 70 hcn 100 PART=uA741
a 0 s 0:13 0 0 0 hln 100 PKGTYPE=DIP8
a 0 s 0:13 0 0 0 hln 100 GATE=
a 0 a 0:13 0 0 0 hln 100 PKGREF=U1
a 0 ap 9 0 14 0 hln 100 REFDES=U1
part 1 titleblk 970 720 h
a 1 s 13 0 350 10 hcn 100 PAGESIZE=A
a 1 s 13 0 180 60 hcn 100 PAGETITLE=
a 1 s 13 0 340 95 hrn 100 PAGECOUNT=1
a 1 s 13 0 300 95 hrn 100 PAGENO=1
@conn
w 69
a 0 up 0:33 0 0 0 hln 100 V=
s 360 150 300 150 68
a 0 up 33 0 330 149 hct 100 V=
s 290 200 300 200 72
s 300 200 310 200 112
s 300 150 300 200 70
w 158
a 0 up 0:33 0 0 0 hln 100 V=
s 170 160 170 170 157
a 0 up 33 0 172 165 hlt 100 V=
w 162
a 0 up 0:33 0 0 0 hln 100 V=
s 350 180 350 190 161
a 0 up 33 0 352 185 hlt 100 V=
w 160
a 0 up 0:33 0 0 0 hln 100 V=
s 170 240 170 230 316
a 0 up 33 0 172 215 hlt 100 V=
w 24
a 0 up 0:33 0 0 0 hln 100 V=
s 220 340 220 330 355
a 0 up 33 0 222 325 hlt 100 V=
w 349
a 0 up 0:33 0 0 0 hln 100 V=
s 130 220 110 220 25
s 110 220 110 280 361
s 220 290 220 280 354
s 220 280 220 270 365
s 110 280 220 280 363
a 0 up 33 0 165 279 hct 100 V=
w 52
a 0 up 0:33 0 0 0 hln 100 V=
s 370 340 360 340 51
a 0 up 33 0 365 339 hct 100 V=
w 434
a 0 up 0:33 0 0 0 hln 100 V=
s 300 300 300 240 435
a 0 up 33 0 302 270 hlt 100 V=
s 300 240 310 240 437
w 164
a 0 up 0:33 0 0 0 hln 100 V=
s 350 260 350 250 318
a 0 up 33 0 352 235 hlt 100 V=
w 382
a 0 up 0:33 0 0 0 hln 100 V=
s 300 340 320 340 424
s 290 340 300 340 392
a 0 up 33 0 300 344 hct 100 V=
w 122
a 0 up 0:33 0 0 0 hln 100 V=
s 480 220 490 220 459
s 500 220 510 220 467
s 490 220 500 220 476
s 490 250 490 220 123
a 0 up 33 0 492 235 hlt 100 V=
w 127
a 0 up 0:33 0 0 0 hln 100 V=
s 490 290 490 310 126
s 520 310 520 240 130
a 0 up 33 0 522 275 hlt 100 V=
s 490 310 510 310 138
s 510 310 520 310 473
s 510 320 510 310 136
w 447
a 0 up 0:33 0 0 0 hln 100 V=
s 570 200 580 200 446
s 580 200 580 210 448
a 0 up 33 0 582 205 hlt 100 V=
w 451
a 0 up 0:33 0 0 0 hln 100 V=
s 530 200 520 200 450
a 0 up 33 0 525 199 hct 100 V=
w 453
a 0 up 0:33 0 0 0 hln 100 V=
s 580 250 580 240 452
a 0 up 33 0 582 245 hlt 100 V=
w 406
a 0 up 0:33 0 0 0 hln 100 V=
s 220 200 250 200 348
s 210 200 220 200 16
s 220 200 220 230 18
a 0 up 33 0 237 185 hlt 100 V=
w 74
a 0 up 0:33 0 0 0 hln 100 V=
s 400 150 420 150 73
s 420 150 420 220 75
a 0 up 33 0 437 185 hlt 100 V=
s 420 220 390 220 77
s 440 220 420 220 488
w 482
a 0 up 0:33 0 0 0 hln 100 V=
s 60 180 130 180 483
a 0 up 33 0 110 164 hct 100 V=
s 60 200 60 180 490
@junction
j 350 180
+ s 154
+ w 162
j 400 150
+ p 67 2
+ w 74
j 440 220
+ p 115 1
+ w 74
j 420 220
+ w 74
+ w 74
j 170 240
+ s 315
+ w 160
j 220 330
+ p 15 1
+ w 24
j 220 340
+ s 22
+ w 24
j 220 290
+ p 15 2
+ w 349
j 220 270
+ p 14 1
+ w 349
j 220 280
+ w 349
+ w 349
j 250 200
+ p 62 1
+ w 406
j 290 200
+ p 62 2
+ w 69
j 310 200
+ p 3 +
+ w 69
j 350 190
+ p 3 V+
+ w 162
j 390 220
+ p 3 OUT
+ w 74
j 130 220
+ p 2 -
+ w 349
j 210 200
+ p 2 OUT
+ w 406
j 170 170
+ p 2 V+
+ w 158
j 170 230
+ p 2 V-
+ w 160
j 170 160
+ s 153
+ w 158
j 220 230
+ p 14 2
+ w 406
j 220 200
+ w 406
+ w 406
j 360 150
+ p 67 1
+ w 69
j 300 200
+ w 69
+ w 69
j 320 340
+ p 33 1
+ w 382
j 300 340
+ p 34 2
+ w 382
j 290 340
+ p 32 2
+ w 382
j 360 340
+ p 33 2
+ w 52
j 370 340
+ s 50
+ w 52
j 300 300
+ p 34 1
+ w 434
j 310 240
+ p 3 -
+ w 434
j 250 340
+ s 41
+ p 32 1
j 350 250
+ p 3 V-
+ w 164
j 350 260
+ s 314
+ w 164
j 20 320
+ p 7 +
+ s 8
j 20 360
+ p 7 -
+ s 9
j 50 360
+ p 309 -
+ s 178
j 50 320
+ p 309 +
+ s 177
j 90 360
+ p 191 -
+ s 190
j 90 320
+ p 191 +
+ s 189
j 480 220
+ p 115 2
+ w 122
j 500 220
+ p 119 b
+ w 122
j 490 290
+ p 120 1
+ w 127
j 520 240
+ p 119 e
+ w 127
j 510 320
+ s 135
+ w 127
j 510 310
+ w 127
+ w 127
j 570 200
+ p 139 1
+ w 447
j 580 210
+ p 215 1
+ w 447
j 530 200
+ p 139 2
+ w 451
j 520 200
+ p 119 c
+ w 451
j 580 240
+ p 215 2
+ w 453
j 580 250
+ s 147
+ w 453
j 490 250
+ p 120 2
+ w 122
j 490 220
+ w 122
+ w 122
j 130 180
+ p 2 +
+ w 482
j 60 200
+ s 489
+ w 482
@attributes
a 0 s 0:13 0 0 0 hln 100 PAGETITLE=
a 0 s 0:13 0 0 0 hln 100 PAGENO=1
a 0 s 0:13 0 0 0 hln 100 PAGESIZE=A
a 0 s 0:13 0 0 0 hln 100 PAGECOUNT=1
@graphics
