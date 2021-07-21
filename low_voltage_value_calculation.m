clc
clear all
close all


f=5:19;
n_frequency= length(f);
s_opt=0.15;
r1=25.6;
l1=.1680;
r2=18.58;
l2=.1680;
lm=2.0275;
p=4;
n_sync=120*f/p;%46 synchronous speed value 
w_sync=n_sync*2*pi/60;% syncronos speed in rad/s
x1=2*pi*f*l1;% 46 stator impedence value
x2=2*pi*f*l2;%46 rotor impedence value
xm=2*pi*f*lm;%46 magnetization impedence value
z_th=(((1j*xm).*(r1+1j*x1))./(r1+1j*(x1+xm)));%46 thevenin impedence value
r_th=real(z_th);%46 rth
x_th=imag(z_th);%46 xth

T_pump=(1.177e-04)*(1-s_opt)^2*w_sync.^2;

v_th_temp=0;
v_phase_temp=0;
vline2line=zeros(1,n_frequency);
for i=1:n_frequency
v_th_temp= sqrt(T_pump(i)*(w_sync(i)*((r_th(i)+(r2/(s_opt)))^2+(x_th(i)+x2(i))^2)*(s_opt))/(3*r2));

v_phase_temp=v_th_temp*sqrt(r1^2+(x1(i)+xm(i)).^2)/xm(i);
vline2line(i)=v_phase_temp*sqrt(3);

end
