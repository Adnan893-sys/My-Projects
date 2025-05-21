* Schematics Aliases *

.ALIASES
R_R1            R1(1=$N_0002 2=$N_0001 )
R_R2            R2(1=$N_0001 2=Vin )
R_R4            R4(1=$N_0003 2=$N_0002 )
R_R5            R5(1=$N_0005 2=$N_0004 )
D_D1            D1(1=$N_0004 2=0 )
D_D2            D2(1=$N_0006 2=0 )
D_D3            D3(1=$N_0007 2=0 )
D_D4            D4(1=$N_0008 2=0 )
R_R6            R6(1=$N_0009 2=$N_0008 )
X_U1A           U1A(+=$N_0010 -=$N_0001 V+=6v V-=0 OUT=$N_0009 )
X_U2A           U2A(+=$N_0010 -=Vin V+=6v V-=0 OUT=$N_0005 )
R_R7            R7(1=$N_0011 2=$N_0006 )
X_U3A           U3A(+=$N_0010 -=$N_0003 V+=12v V-=0 OUT=$N_0011 )
R_R8            R8(1=$N_0012 2=$N_0007 )
X_U4A           U4A(+=$N_0010 -=$N_0002 V+=6v V-=0 OUT=$N_0012 )
R_R9            R9(1=$N_0003 2=0 )
V_V1            V1(+=Vin -=0 )
R_R3            R3(1=Vin 2=6v )
_    _(12v=12v)
_    _(Vin=Vin)
_    _(6v=6v)
.ENDALIASES

