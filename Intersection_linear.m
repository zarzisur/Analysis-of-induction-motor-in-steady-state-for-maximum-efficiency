clear all
% close all
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
    



figure 
Tpump= Kp.*(1-S_cut).^2.*w_sync.^2;
Nr_cut=(1-S_cut).*w_sync*60/(2*pi);
plot(Nr_cut,Tpump,'r+:','Linewidth',1);
xlabel('Spped')
ylabel('Torque')
title('Intersection point torque for linear method')

figure
plot(Nr_cut,S_cut,'b*','Linewidth',1);
xlabel('Speed')
ylabel('Slip at intersection point');
title('Intersection point slip for linear method')

figure
plot(f,vline2line,'b*','Linewidth',1);
xlabel('Frequency')
ylabel('Command line to line voltage');
title('Voltage Vs Frequency in Linear Method');

figure
plot(Nr_cut,pf_linear,'b*','Linewidth',1);
xlabel('Speed')
ylabel('Power factor at intersection point');
title('Intersection point power factor for linear method')

figure
plot(Nr_cut,eff_linear,'b*','Linewidth',1);
xlabel('Speed')
ylabel('Efficiency at intersection point');
title('Intersection point efficiency for linear method')

