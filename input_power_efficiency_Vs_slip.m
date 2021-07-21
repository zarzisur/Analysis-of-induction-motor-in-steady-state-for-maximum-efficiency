tic
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
s=(0:1:200)/200;% Generating 101 slip value which will be used for each V/f pair 
s(1)=0.001;% slip should not be zero anyway
n_slip=length(s);
x1=2*pi*f*l1;% 46 stator impedence value
x2=2*pi*f*l2;%46 rotor impedence value
xm=2*pi*f*lm;%46 magnetization impedence value
z_th=(((1j*xm).*(r1+1j*x1))./(r1+1j*(x1+xm)));%46 thevenin impedence value
r_th=real(z_th);%46 rth
x_th=imag(z_th);%46 xth
v_th=v_phase.*(xm./sqrt(r1^2+(x1+xm).^2));%46 vth value


%%%%%% To store all data for analysis a data cell is created. Here data
%%%%%% will be saved like this format:
%%%%%% data={frequency, voltage} {slip} {Torque} {Power}
data=cell(n_frequency,4);% cell created , 46 row and 4 column

%%%%% efficiency cell will store data like this
%%%%% eff_cell={frequency} {slip} {Iin} {pf} {Pin} (efficency)

eff_cell=cell(n_frequency+1,6)

%%%%%Initialization of  data cell%%%%%
data(:,1)={zeros(1,2)};
data(:,2)={zeros(1,n_slip)};
data(:,3)={zeros(1,n_slip)};
data(:,4)={zeros(1,n_slip)};

%%%% Initaialization of effciency cell
eff_cell(1,1)={'Frequency'}; % frequency
eff_cell(1,2)={'Slip'}; %slip
eff_cell(1,3)={'Input Current'}; %Iin
eff_cell(1,4)={'Power factor'}; %Pf
eff_cell(1,5)={'Input Power'}; %Pin
eff_cell(1,6)={'Efficiency'}; %efficiency
eff_cell(2:n_frequency+1,1)={zeros(1,1)}; % frequency
eff_cell(2:n_frequency+1,2)={zeros(1,n_slip)}; %slip
eff_cell(2:n_frequency+1,3)={zeros(1,n_slip)}; %Iin
eff_cell(2:n_frequency+1,4)={zeros(1,n_slip)}; %Pf
eff_cell(2:n_frequency+1,5)={zeros(1,n_slip)}; %Pin
eff_cell(2:n_frequency+1,6)={zeros(1,n_slip)}; %efficiency


%%%%%% main calculation%%%%%%%

for n=1:n_frequency
    nm=(1-s)*n_sync(n);
    wm=nm*2*pi/60;

    t_ind=zeros(1,n_slip);
    power=zeros(1,n_slip);
    z_in=zeros(1,n_slip);
    i_in=zeros(1,n_slip);
    theta_in=zeros(1,n_slip);
    mag_in=zeros(1,n_slip);
    pf=zeros(1,n_slip);
    p_in=zeros(1,n_slip);
    eff=zeros(1,n_slip);
    for k=1:n_slip
        %%% Induced/ Electromagnetic Torque calculation
        t_ind(k)=(3*r2*v_th(n)^2)/(w_sync(n)*((r_th(n)+(r2/s(k)))^2+(x_th(n)+x2(n))^2)*s(k));
        %%%% Mechanical Power calculation
        power(k)=t_ind(k)*wm(k);
        %%%%Input Impedence Calculation
        z_in(k)=r1+1j*x1(n)+((((r2./s(k))+1j*x2(n)).*(1j*xm(n)))./((r2./s(k))+1j*(x2(n)+xm(n))));
        %%%%Input Current
        i_in(k)=v_phase(n)/z_in(k);
        %%%%%%% cartesian to Polar
        [theta_in(k),mag_in(k)]=cart2pol(real(i_in(k)),imag(i_in(k))); 
         %%%% Power factor Calculation
         pf(k)=cos(theta_in(k));
   
        %%%Input Power calculation
        p_in(k)=3*v_phase(n).*mag_in(k).*pf(k);
        eff(k)= power(k)/p_in(k);
    end

   %%%%%%% Efficiency Cell Update
   
    eff_cell(n+1,1)={f(1,n)}; % frequency
    eff_cell(n+1,2)={s}; %slip
    eff_cell(n+1,3)={mag_in}; %Iin
    eff_cell(n+1,4)={pf}; %Pf
    eff_cell(n+1,5)={p_in}; %Pin
    eff_cell(n+1,6)={eff}; %efficiency



    
    %%%% Data cell update

    data(n,1)={[f(1,n),vline2line(1,n)]};%This is 1st column of cell showing freq and voltage
    data(n,2)={s};%This is 2nd column of cell showing slip
    data(n,3)={t_ind};%This is 3rd colulmn of cell showing electromagnetic torque
    data(n,4)={power};%This is 4th column of cell showing power
    figure(1)
    plot(nm,t_ind);
    hold on
    figure(2)
    plot(nm,power)
    hold on
end
%%%%%%% Finding Pump Torque Speed Cureve%%%%%
power= .5*746;%change power

Nr=1402.5;
Wr=(Nr*2*pi/60);%%%slip=0.065%% 146.869
T=2.5391;
Kp=(T/(Wr^2));
Sopt=[];
for n=1:46
    Sopt_temp=SlipCalculation(v_phase(n),f(n),Kp);
    Sopt=[Sopt Sopt_temp];
end
figure (1)
Tpump= Kp.*(1-Sopt).^2.*w_sync.^2;
Nr_opt=(1-Sopt).*w_sync*60/(2*pi);
plot(Nr_opt,Tpump,'r+:','Linewidth',1);

%%%%%% End Finding Pump`s torque speed curve


%%%%%% Finding maximum power possible for each frequency and corresponiding
%%%%%% torque and slip value

p_max=[];slip_max=[];torque_max=[];
for n=1:n_frequency
   [p_max_temp,index]=max(data{n,4});
   p_max=[p_max p_max_temp];
   slip_max=[slip_max data{n,2}(1,index)];
   torque_max=[torque_max data{n,3}(1,index)];
end
nm_max=(1-slip_max).*f*120/p;

figure(3)
title('Frequency vs Max Power,Slip @ Max Power, Torque @Max Power')
subplot(3,1,1)
plot(nm_max,p_max);
xlabel('frequency') 
ylabel('Maximum Power')
subplot(3,1,2)
plot(f,slip_max);
xlabel('frequency') 
ylabel('Slip @ Max Power')
subplot(3,1,3)
plot(f,torque_max);
xlabel('frequency') 
ylabel('Torque @ Max Power')

figure(2)
plot(nm_max,p_max,'k+:','Linewidth',1);



%%%%%%%%%% End Maximum value calculation



toc
