f=50;
Vphase=v_phase(46);
Kp=1.176e-4;
Ns=120*f/p;
Ws=Ns*2*pi/60;
X1=2*pi*f*l1;
X2=2*pi*f*l2;
Xm=2*pi*f*lm;
Z_th=(((1j*Xm).*(r1+1j*X1))./(r1+1j*(X1+Xm)));
Rth=real(Z_th);%46 rth
Xth=imag(Z_th);%46 xth
Vth=Vphase.*(Xm./sqrt(r1^2+(X1+Xm).^2));%46 vth valu
fcnS=@(S) (Kp*(1-S).^2*Ws.^3)-((3*Vth.^2*r2)/(S*((r2/S+Rth).^2+(Xth+X2).^2)));
ezplot(fcnS,[0 1]);
grid on
S= fzero(fcnS,.01)