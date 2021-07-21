clc
clear all
close all
%%%%% Motor Parameter%%%%%%%%%%%%%%%%
f=5:1:50;% generating 46 frequency value
n_frequency= length(f);
r1=25.6;
l1=.1680;
r2=18.58;
l2=.1680;
lm=2.0275;
p=4;



%%%%%% Essential value calculation%%%%%

vline2line=f*415/50;% generating 46 line to line voltage value correspondig to V/f relation
v_phase=vline2line/sqrt(3);% 46 phase voltage of the line2line voltage
n_sync=120*f/p;%46 synchronous speed value 
w_sync=n_sync*2*pi/60;% syncronos speed in rad/s
x1=2*pi*f*l1;% 46 stator impedence value
x2=2*pi*f*l2;%46 rotor impedence value
xm=2*pi*f*lm;%46 magnetization impedence value
z_th=(((1j*xm).*(r1+1j*x1))./(r1+1j*(x1+xm)));%46 thevenin impedence value
r_th=real(z_th);%46 rth
x_th=imag(z_th);%46 xth
v_th=v_phase.*(xm./sqrt(r1^2+(x1+xm).^2));%46 vth value

%%%%%%% Finding Pump Torque Speed Cureve%%%%%
output_power_linear= .5*746;%change power

Nr=1402.5;
Wr=(Nr*2*pi/60);%%%slip=0.065%% 146.869
T=2.5391;
Kp=(T/(Wr^2));
S_cut=[];
for n=1:46
    S_cut_temp=SlipCalculation(v_phase(n),f(n),Kp);
    S_cut=[S_cut S_cut_temp];
end

%%%%%% End Finding Pump`s torque speed curve





 nm=(1-S_cut).*n_sync;
 wm=nm*2*pi/60;
 
    t_ind_linear=zeros(1,n_frequency);
    output_power_linear=zeros(1,n_frequency);
    z_in_linear=zeros(1,n_frequency);
    i_in_linear=zeros(1,n_frequency);
    theta_in_linear=zeros(1,n_frequency);
    mag_in_linear=zeros(1,n_frequency);
    pf_linear=zeros(1,n_frequency);
    p_in_linear=zeros(1,n_frequency);
    eff_linear=zeros(1,n_frequency);


%%%%%% main calculation%%%%%%%

for n=1:n_frequency
   

    
        %%% Induced/ Electromagnetic Torque calculation
        t_ind_linear(n)=(3*r2*v_th(n)^2)/(w_sync(n)*((r_th(n)+(r2/S_cut(n)))^2+(x_th(n)+x2(n))^2)*S_cut(n));
        %%%% Mechanical Power calculation
        output_power_linear(n)=t_ind_linear(n)*wm(n);
        %%%%Input Impedence Calculation
        z_in_linear(n)=r1+1j*x1(n)+((((r2./S_cut(n))+1j*x2(n)).*(1j*xm(n)))./((r2./S_cut(n))+1j*(x2(n)+xm(n))));
        %%%%Input Current
        i_in_linear(n)=v_phase(n)/z_in_linear(n);
        %%%%%%% cartesian to Polar
        [theta_in_linear(n),mag_in_linear(n)]=cart2pol(real(i_in_linear(n)),imag(i_in_linear(n))); 
         %%%% Power factor Calculation
         pf_linear(n)=cos(theta_in_linear(n));
   
        %%%Input Power calculation
        p_in_linear(n)=3*v_phase(n).*mag_in_linear(n).*pf_linear(n);
        eff_linear(n)= output_power_linear(n)/p_in_linear(n);
end
    



figure(1) 
Tpump= Kp.*(1-S_cut).^2.*w_sync.^2;
Nr_cut=(1-S_cut).*w_sync*60/(2*pi);
plot(Nr_cut,Tpump,'k.:','Linewidth',1);
hold on

figure(2)
plot(f,S_cut,'k.:','Linewidth',1);
hold on


figure(3)
plot(f,vline2line,'k.:','Linewidth',1);
hold on


figure(4)
plot(f,pf_linear,'k.:','Linewidth',1);
hold on


figure(5)
plot(f,eff_linear,'k.:','Linewidth',1);
hold on

figure(6)
plot(f,output_power_linear,'k.:','Linewidth',1);
hold on

figure(7)
plot(f,p_in_linear,'k.:','Linewidth',1);
hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  Quadretic Starts here
%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear all
%%%%% Motor Parameter%%%%%%%%%%%%%%%%
f=5:1:50;% generating 46 frequency value
n_frequency= length(f);
r1=25.6;
l1=.1680;
r2=18.58;
l2=.1680;
lm=2.0275;
p=4;



%%%%%% Essential value calculation%%%%%

vline2line=(f/50).^2*415;% generating 46 line to line voltage value correspondig to V/f relation
v_phase=vline2line/sqrt(3);% 46 phase voltage of the line2line voltage
n_sync=120*f/p;%46 synchronous speed value 
w_sync=n_sync*2*pi/60;% syncronos speed in rad/s
x1=2*pi*f*l1;% 46 stator impedence value
x2=2*pi*f*l2;%46 rotor impedence value
xm=2*pi*f*lm;%46 magnetization impedence value
z_th=(((1j*xm).*(r1+1j*x1))./(r1+1j*(x1+xm)));%46 thevenin impedence value
r_th=real(z_th);%46 rth
x_th=imag(z_th);%46 xth
v_th=v_phase.*(xm./sqrt(r1^2+(x1+xm).^2));%46 vth value

%%%%%%% Finding Pump Torque Speed Cureve%%%%%
output_power= .5*746;%change power

Nr=1402.5;
Wr=(Nr*2*pi/60);%%%slip=0.065%% 146.869
T=2.5391;
Kp=(T/(Wr^2));
S_cut=[];
for n=1:46
    S_cut_temp=SlipCalculation(v_phase(n),f(n),Kp);
    S_cut=[S_cut S_cut_temp];
end

%%%%%% End Finding Pump`s torque speed curve





 nm=(1-S_cut).*n_sync;
 wm=nm*2*pi/60;
 
    t_ind_quadretic=zeros(1,n_frequency);
    output_power_quadretic=zeros(1,n_frequency);
    z_in_quadretic=zeros(1,n_frequency);
    i_in_quadretic=zeros(1,n_frequency);
    theta_in_quadretic=zeros(1,n_frequency);
    mag_in_quadretic=zeros(1,n_frequency);
    pf_quadretic=zeros(1,n_frequency);
    p_in_quadretic=zeros(1,n_frequency);
    eff_quadretic=zeros(1,n_frequency);


%%%%%% main calculation%%%%%%%

for n=1:n_frequency
   

    
        %%% Induced/ Electromagnetic Torque calculation
        t_ind_quadretic(n)=(3*r2*v_th(n)^2)/(w_sync(n)*((r_th(n)+(r2/S_cut(n)))^2+(x_th(n)+x2(n))^2)*S_cut(n));
        %%%% Mechanical Power calculation
        output_power_quadretic(n)=t_ind_quadretic(n)*wm(n);
        %%%%Input Impedence Calculation
        z_in_quadretic(n)=r1+1j*x1(n)+((((r2./S_cut(n))+1j*x2(n)).*(1j*xm(n)))./((r2./S_cut(n))+1j*(x2(n)+xm(n))));
        %%%%Input Current
        i_in_quadretic(n)=v_phase(n)/z_in_quadretic(n);
        %%%%%%% cartesian to Polar
        [theta_in_quadretic(n),mag_in_quadretic(n)]=cart2pol(real(i_in_quadretic(n)),imag(i_in_quadretic(n))); 
         %%%% Power factor Calculation
         pf_quadretic(n)=cos(theta_in_quadretic(n));
   
        %%%Input Power calculation
        p_in_quadretic(n)=3*v_phase(n).*mag_in_quadretic(n).*pf_quadretic(n);
        eff_quadretic(n)= output_power_quadretic(n)/p_in_quadretic(n);
end
    



figure (1)
Tpump= Kp.*(1-S_cut).^2.*w_sync.^2;
Nr_cut=(1-S_cut).*w_sync*60/(2*pi);
plot(Nr_cut,Tpump,'k^:','Linewidth',1);
hold on

figure(2)
plot(f,S_cut,'k^:','Linewidth',1);
hold on

figure(3)
plot(f,vline2line,'k^:','Linewidth',1);
hold on

figure(4)
plot(f,pf_quadretic,'k^:','Linewidth',1);
hold on

figure(5)
plot(f,eff_quadretic,'k^:','Linewidth',1);
hold on


figure(6)
plot(f,output_power_quadretic,'k^:','Linewidth',1);
hold on

figure(7)
plot(f,p_in_quadretic,'k^:','Linewidth',1);
hold on







% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%% Quadretic with Low frquuency constatnt voltage %%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% 
% 
% 
% 
% clear all
% %%%%% Motor Parameter%%%%%%%%%%%%%%%%
% f=5:1:50;% generating 46 frequency value
% n_frequency= length(f);
% r1=25.6;
% l1=.1680;
% r2=18.58;
% l2=.1680;
% lm=2.0275;
% p=4;
% 
% 
% 
% %%%%%% Essential value calculation%%%%%
% 
% vline2line=(f/50).^2*415;% generating 46 line to line voltage value correspondig to V/f relation
% for i=1:15 % low frequency 5 to 10 Hz
%     vline2line(i)=(19/50)^2*415;
% end
% v_phase=vline2line/sqrt(3);% 46 phase voltage of the line2line voltage
% n_sync=120*f/p;%46 synchronous speed value 
% w_sync=n_sync*2*pi/60;% syncronos speed in rad/s
% x1=2*pi*f*l1;% 46 stator impedence value
% x2=2*pi*f*l2;%46 rotor impedence value
% xm=2*pi*f*lm;%46 magnetization impedence value
% z_th=(((1j*xm).*(r1+1j*x1))./(r1+1j*(x1+xm)));%46 thevenin impedence value
% r_th=real(z_th);%46 rth
% x_th=imag(z_th);%46 xth
% v_th=v_phase.*(xm./sqrt(r1^2+(x1+xm).^2));%46 vth value
% 
% %%%%%%% Finding Pump Torque Speed Cureve%%%%%
% output_power= .5*746;%change power
% 
% Nr=1402.5;
% Wr=(Nr*2*pi/60);%%%slip=0.065%% 146.869
% T=2.5391;
% Kp=(T/(Wr^2));
% S_cut=[];
% for n=1:46
%     S_cut_temp=SlipCalculation(v_phase(n),f(n),Kp);
%     S_cut=[S_cut S_cut_temp];
% end
% 
% %%%%%% End Finding Pump`s torque speed curve
% 
% 
% 
% 
% 
%  nm=(1-S_cut).*n_sync;
%  wm=nm*2*pi/60;
%  
%     t_ind_quadretic=zeros(1,n_frequency);
%     output_power_quadretic=zeros(1,n_frequency);
%     z_in_quadretic=zeros(1,n_frequency);
%     i_in_quadretic=zeros(1,n_frequency);
%     theta_in_quadretic=zeros(1,n_frequency);
%     mag_in_quadretic=zeros(1,n_frequency);
%     pf_quadretic=zeros(1,n_frequency);
%     p_in_quadretic=zeros(1,n_frequency);
%     eff_quadretic=zeros(1,n_frequency);
% 
% 
% %%%%%% main calculation%%%%%%%
% 
% for n=1:n_frequency
%    
% 
%     
%         %%% Induced/ Electromagnetic Torque calculation
%         t_ind_quadretic(n)=(3*r2*v_th(n)^2)/(w_sync(n)*((r_th(n)+(r2/S_cut(n)))^2+(x_th(n)+x2(n))^2)*S_cut(n));
%         %%%% Mechanical Power calculation
%         output_power_quadretic(n)=t_ind_quadretic(n)*wm(n);
%         %%%%Input Impedence Calculation
%         z_in_quadretic(n)=r1+1j*x1(n)+((((r2./S_cut(n))+1j*x2(n)).*(1j*xm(n)))./((r2./S_cut(n))+1j*(x2(n)+xm(n))));
%         %%%%Input Current
%         i_in_quadretic(n)=v_phase(n)/z_in_quadretic(n);
%         %%%%%%% cartesian to Polar
%         [theta_in_quadretic(n),mag_in_quadretic(n)]=cart2pol(real(i_in_quadretic(n)),imag(i_in_quadretic(n))); 
%          %%%% Power factor Calculation
%          pf_quadretic(n)=cos(theta_in_quadretic(n));
%    
%         %%%Input Power calculation
%         p_in_quadretic(n)=3*v_phase(n).*mag_in_quadretic(n).*pf_quadretic(n);
%         eff_quadretic(n)= output_power_quadretic(n)/p_in_quadretic(n);
% end
%     
% 
% 
% 
% figure (1)
% Tpump= Kp.*(1-S_cut).^2.*w_sync.^2;
% Nr_cut=(1-S_cut).*w_sync*60/(2*pi);
% plot(Nr_cut,Tpump,'kx-.','Linewidth',1);
% hold on
% 
% figure(2)
% plot(f,S_cut,'kx-.','Linewidth',1);
% hold on
% 
% figure(3)
% plot(f,vline2line,'kx-.','Linewidth',1);
% hold on
% 
% figure(4)
% plot(f,pf_quadretic,'kx-.','Linewidth',1);
% hold on
% 
% figure(5)
% plot(f,eff_quadretic,'kx-.','Linewidth',1);
% hold on
% 
% 
% figure(6)
% plot(f,output_power_quadretic,'kx-.','Linewidth',1);
% hold on
% 
% figure(7)
% plot(f,p_in_quadretic,'kx-.','Linewidth',1);
% hold on
% 





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Quadretic with optimum voltage at low frequency region%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







clear all

%%%%% Motor Parameter%%%%%%%%%%%%%%%%
f=5:1:50;% generating 46 frequency value
n_frequency= length(f);
r1=25.6;
l1=.1680;
r2=18.58;
l2=.1680;
lm=2.0275;
p=4;



%%%%%% Essential value calculation%%%%%

vline2line=(f/50).^2*415;% generating 46 line to line voltage value correspondig to V/f relation
vline2line(1)=8.5853;
vline2line(2)=11.1413;
vline2line(3)=13.9369;
vline2line(4)=16.9558;
vline2line(5)=20.1859;
vline2line(6)=23.6179;
vline2line(7)=27.2446;
vline2line(8)=31.0604;
vline2line(9)=35.0609;
vline2line(10)=39.2428;
vline2line(11)=43.6036;
vline2line(12)=48.1415;
vline2line(13)=52.8552;
vline2line(14)=57.7440;
vline2line(15)=62.8076;





v_phase=vline2line/sqrt(3);% 46 phase voltage of the line2line voltage
n_sync=120*f/p;%46 synchronous speed value 
w_sync=n_sync*2*pi/60;% syncronos speed in rad/s
x1=2*pi*f*l1;% 46 stator impedence value
x2=2*pi*f*l2;%46 rotor impedence value
xm=2*pi*f*lm;%46 magnetization impedence value
z_th=(((1j*xm).*(r1+1j*x1))./(r1+1j*(x1+xm)));%46 thevenin impedence value
r_th=real(z_th);%46 rth
x_th=imag(z_th);%46 xth
v_th=v_phase.*(xm./sqrt(r1^2+(x1+xm).^2));%46 vth value

%%%%%%% Finding Pump Torque Speed Cureve%%%%%
output_power= .5*746;%change power

Nr=1402.5;
Wr=(Nr*2*pi/60);%%%slip=0.065%% 146.869
T=2.5391;
Kp=(T/(Wr^2));
S_cut=[];
for n=1:46
    S_cut_temp=SlipCalculation(v_phase(n),f(n),Kp);
    S_cut=[S_cut S_cut_temp];
end

%%%%%% End Finding Pump`s torque speed curve





 nm=(1-S_cut).*n_sync;
 wm=nm*2*pi/60;
 
    t_ind_quadretic=zeros(1,n_frequency);
    output_power_quadretic=zeros(1,n_frequency);
    z_in_quadretic=zeros(1,n_frequency);
    i_in_quadretic=zeros(1,n_frequency);
    theta_in_quadretic=zeros(1,n_frequency);
    mag_in_quadretic=zeros(1,n_frequency);
    pf_quadretic=zeros(1,n_frequency);
    p_in_quadretic=zeros(1,n_frequency);
    eff_quadretic=zeros(1,n_frequency);


%%%%%% main calculation%%%%%%%

for n=1:n_frequency
   

    
        %%% Induced/ Electromagnetic Torque calculation
        t_ind_quadretic(n)=(3*r2*v_th(n)^2)/(w_sync(n)*((r_th(n)+(r2/S_cut(n)))^2+(x_th(n)+x2(n))^2)*S_cut(n));
        %%%% Mechanical Power calculation
        output_power_quadretic(n)=t_ind_quadretic(n)*wm(n);
        %%%%Input Impedence Calculation
        z_in_quadretic(n)=r1+1j*x1(n)+((((r2./S_cut(n))+1j*x2(n)).*(1j*xm(n)))./((r2./S_cut(n))+1j*(x2(n)+xm(n))));
        %%%%Input Current
        i_in_quadretic(n)=v_phase(n)/z_in_quadretic(n);
        %%%%%%% cartesian to Polar
        [theta_in_quadretic(n),mag_in_quadretic(n)]=cart2pol(real(i_in_quadretic(n)),imag(i_in_quadretic(n))); 
         %%%% Power factor Calculation
         pf_quadretic(n)=cos(theta_in_quadretic(n));
   
        %%%Input Power calculation
        p_in_quadretic(n)=3*v_phase(n).*mag_in_quadretic(n).*pf_quadretic(n);
        eff_quadretic(n)= output_power_quadretic(n)/p_in_quadretic(n);
end
    



figure(1) 
Tpump= Kp.*(1-S_cut).^2.*w_sync.^2;
Nr_cut=(1-S_cut).*w_sync*60/(2*pi);
plot(Nr_cut,Tpump,'kp-','Linewidth',1);
xlabel('Speed')
ylabel('Torque')
title('Torque Vs Speed for Pump Load');
legend('linear','Quadretic','Constant Voltage','Optimized Voltage');

figure(2)
plot(f,S_cut,'kp-','Linewidth',1);
xlabel('Frequency')
ylabel('Slip at intersection point');
title('Slip Vs frequency for Pump laod');
legend('linear','Quadretic','Constant Voltage','Optimized Voltage');

figure(3)
plot(f,vline2line,'kp-','Linewidth',1);
xlabel('Frequency')
ylabel('Command line to line voltage');
title('Voltage Vs Frequency for Pump Load');
legend('linear','Quadretic','Constant Voltage','Optimized Voltage');


figure(4)
plot(f,pf_quadretic,'kp-','Linewidth',1);
xlabel('Frequency')
ylabel('Power factor at intersection point');
title('Power factor Vs Frequency for Pump Load');
legend('linear','Quadretic','Constant Voltage','Optimized Voltage');


figure(5)
plot(f,eff_quadretic,'kp-','Linewidth',1);
xlabel('Frequency')
ylabel('Efficiency at intersection point');
title('Efficiency VS Frequency for Pump Load');
legend('linear','Quadretic','Constant Voltage','Optimized Voltage');



figure(6)
plot(f,output_power_quadretic,'kp-','Linewidth',1);
xlabel('Frequency')
ylabel('Output Power intersection point');
title('Output Power VS Frequency for Pump Load');
legend('linear','Quadretic','Constant Voltage','Optimized Voltage');


figure(7)
plot(f,p_in_quadretic,'kp-','Linewidth',1);
xlabel('Frequency')
ylabel('Input Power at intersection point');
title('Input Power VS Frequency for Pump Load');
legend('linear','Quadretic','Optimized Voltage');



