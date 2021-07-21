
clc

clear all
%%%%% Motor Parameter%%%%%%%%%%%%%%%%
f=5:1:50;% generating 46 frequency value
r1=25.6;
l1=.1680;
r2=18.58;
l2=.1680;
lm=2.0275;
p=4;



%%%%%% Essential value calculation%%%%%

vline2line=(f./50).^2.*415;% generating 46 line to line voltage value correspondig to V/f relation
v_phase=vline2line/sqrt(3);% 46 phase voltage of the line2line voltage
n_sync=120*f/p;%46 synchronous speed value 
w_sync=n_sync*2*pi/60;% syncronos speed in rad/s
s=(0:1:100)/100;% Generating 101 slip value which will be used for each V/f pair 
s(1)=0.001;% slip should not be zero anyway
x1=2*pi*f*l1;% 46 stator impedence value
x2=2*pi*f*l2;%46 rotor impedence value
xm=2*pi*f*lm;%46 magnetization impedence value
z_th=(((1j*xm).*(r1+1j*x1))./(r1+1j*(x1+xm)));%46 thevenin impedence value
r_th=real(z_th);%46 rth
x_th=imag(z_th);%46 xth
v_th=v_phase.*(xm./sqrt(r1^2+(x1+xm).^2));%46 vth value


%%% Induced/ Electromagnetic Torque and output mechanical power calculation
t_ind=zeros(101,46);
p_out=zeros(101,46);
nm=zeros(1,101);%%Just a bucket to update value
wm=zeros(1,101);%% Just a bucket to update value
for column=1:46
    nm=(1-s)*n_sync(column);
    wm=nm*2*pi/60;
    for row=1:101
        t_ind(row,column)=(3*r2.*v_th(column)^2)./(w_sync(column).*((r_th(column)+(r2/s(row)))^2+(x_th(column)+x2(column))^2)*s(row));
        p_out(row,column)=t_ind(row,column).*wm(row);
    end
end





[fr,sc]=meshgrid(f,s);%%% fr is a 2D matrix.It`s value changes on column.all Row is duplicate of
%%% first row and number of row is equal to s`s number. sc is a 2d matrix. It`s value changes on 
%%% row.all Column is  duplicate of 1st column

%%%%Input Impedence Calculation
z_in=r1+1j*2*pi.*fr*l1+((((r2./sc)+1j*2*pi.*fr*l2).*(1j*2*pi.*fr*lm))./((r2./sc)+1j*2*pi.*fr*(l2+lm)));

%%%%%% input current calculation
i_in=zeros(101,46);
for column=1:46
    for row=1:101
        i_in(row,column)=v_phase(column)./z_in(row,column);%% as fr only chage in column so v_phase`s 
        %%% value change in new column  
    end
end

%%%%%%% cartesian to Polar
[theta_in,mag_in]=cart2pol(real(i_in),imag(i_in)); 
        
%%%% Power factor Calculation
pf=cos(theta_in);

%%%%% Input Power Calculation
p_in=zeros(101,46);
for column=1:46
    for row=1:101
        p_in(row,column)=3.*v_phase(column).*mag_in(row,column).*pf(row,column);%% as fr only chage in column so v_phase`s 
        %%% value change in new column  
    end
end

%%%%%% Efficiency Calculation
eff=zeros(101,46);
eff=p_out./p_in;
% 
%     figure
%     surf(fr,sc,pf);
%     xlabel('frequency');
%     ylabel('slip')
%     zlabel('power factor for quadretic method')
%     %%%shading interp % gets rid of black line in surface plot
%     colormap(jet(50)); % give a predefined colour choice
%     colorbar % Add a colorbar that acts as a legend for colors
%     
%     
%     figure
%     contourf(fr,sc,pf);
%     xlabel('frequency');
%     ylabel('slip')
%     zlabel('power factor for quadretic method')
%     title('Contour of power factor for quadretic method ')
%     %%%shading interp % gets rid of black line in surface plot
%     colormap(jet(50)); % give a predefined colour choice
%     colorbar % Add a colorbar that acts as a legend for colors
%    
%     figure
%     contourf(fr,sc,mag_in);
%     xlabel('frequency');
%     ylabel('slip');
%     zlabel('Input Phase current,RMS,for quadretic method');
%     title('Input Phase current,RMS,for quadretic method');
%      colormap(jet(50));
%     colorbar
%     
%     
    
    figure
    contourf(fr,sc,p_in);
    xlabel('frequency');
    ylabel('slip');
    zlabel('Input Power for quadretic method');
    title('Input Power for quadretic method'); 
    colormap(gray);
    colorbar
    
    
    
%     figure
%     surf(fr,sc,p_out);
%     xlabel('frequency');
%     ylabel('slip');
%     zlabel('Output Power for quadretic method');
%      colormap(jet(50));
%     colorbar
%     
%     
%     figure
%     surf(fr,sc,eff);
%     xlabel('frequency');
%     ylabel('slip');
%     zlabel('Efficiency for quadretic method');
%     colormap(gray(50));
%     colorbar
%     
    
    %%%%%%Contour
    
     figure
    contourf(fr,sc,eff);
    xlabel('frequency');
    ylabel('slip');
    zlabel('Efficiency');
    title('Efficiency Using contour mapping for quadretic method')
    colormap(jet(50));
    colorbar
    
%     %%%%%% Filled Contour, contourf
%     figure
%     contourf(fr,sc,eff);
%     xlabel('frequency');
%     ylabel('slip');
%     zlabel('Efficiency');
%     title('Efficiency Using  contour mapping for quadretic method')
%     colormap(jet(50));
%     colorbar
%     
%     
%     %%%%%% combine surf and contour, surfc
%     figure(8)
%     surfc(fr,sc,eff);
%     xlabel('frequency');
%     ylabel('slip');
%     zlabel('Efficiency');
%     title('Efficiency Using combined surf and  contour mapping')
%     colormap(jet(50));
%     colorbar
%     
    