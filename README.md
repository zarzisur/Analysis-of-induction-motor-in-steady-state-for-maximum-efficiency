# Analysis-of-induction-motor-in-steady-state-for-maximum-efficiency

A 0.5 H. P three phase induction motor from Daut et al.`s experiment [1] is analyzed for different frequency and slip with two types of excitation source: linear V/f [2] and
quadratic V/f [3]. Two observations are made. First observation is power factor of the motor only depends on frequency and slip, because for a fixed frequency and slip value,
input impedance is defined. Second observation is, for same value of frequency and slip, efficiency is same for both linear and quadratic method (fig. 1 and fig. 2), that means
efficiency is defined by only frequency and slip. The reason is: as frequency (f) and slip (s) is same for both method (linear and quadratic) so frequency and slip dependent
parameters are same. That means impedance value x1, x2, xm, r2/s, input impedance (Zin), power factor (pf) are same.

<img width="445" alt="efficiency" src="https://user-images.githubusercontent.com/35787202/126745332-862f5a4e-13e2-444b-b894-17dc1389222b.PNG">

<img width="960" alt="ontour" src="https://user-images.githubusercontent.com/35787202/126766094-e5fcd4e5-fb47-4a8c-848c-96f1a823833e.png">
Figure 1 Contour Mapping of Efficiency using Quadratic V/f

Now that we know efficiency relation with frequency and slip, motor can be excited with different V/f profile and performance can be observed and compared and an effective
V/f profile for maximum efficiency operation can be generated.
Pump load torque is proportional to square of it`s speed. T_p=K_(p )*w_r^2
From rated operating point, K_p`s value is found. All the performance parameter calculations in below (i.e. input power, output power, efficiency etc.) were done after
finding operating slip in a particular frequency and voltage profile. Operating slip was found by finding the intersection point of pump and motor`s torque speed curve.
 In our experiment, two types of voltage profile is used first: linear V/f profile and Quadratic V/f profile (Fig.3). It has been seen that linear profile gives high
 efficiency in higher frequency region where in low frequency region quadratic give higher efficiency (Fig.4). But from slip profile (Fig.5) we can see neither linear nor
 quadratic operate within optimum slip band during low frequency operation. So, with backward calculation an optimum voltage profile is calculate so that slip become 0.15
 for low frequency operation. We can see an advantage of quadratic profile from power factor curve (Fig.6) that quadratic profile gives higher power factor performance than
 linear. So, we created a hybrid profile with pure optimum voltage value in low frequency and quadratic voltage profile in high frequency. If we want to implement this
 hybrid profile then we need a equation. So, after 1st degree interpolation, linear straight-line equation is found and used. Unfortunately, it gives poor performance in
 middle frequency region. So, we generate a semi optimum linear profile with voltage value at 5Hz from optimum value and voltage value at 25Hz from quadratic value. As in
 higher frequency region linear profile give high efficiency performance , so semi optimum profile is merged with linear to from a complete V/f profile. Figure 3 shows all
 four V/f profile namely: linear, quadratic, pure optimum and semi optimum. 
 <img width="960" alt="3" src="https://user-images.githubusercontent.com/35787202/126766612-85372aad-eea1-4756-80c4-9edda103613e.png">
 Figure 3 Voltage Profile Vs frequency
 <img width="960" alt="4" src="https://user-images.githubusercontent.com/35787202/126766739-63ad2daa-da44-4fb3-885e-07a3da0b7546.png">
 Figure 4 Efficiency Vs Frequency in different voltage profile
 <img width="960" alt="5" src="https://user-images.githubusercontent.com/35787202/126766814-80fe4fdb-12f5-44a8-9c30-54e208c12f40.png">
Figure 5  Slip Vs Frequency in different Voltage Profile
<img width="960" alt="6" src="https://user-images.githubusercontent.com/35787202/126766899-7bbf7374-cab1-4f57-b37f-8a8f3dd4b107.png">
Figure 6 Power Factor Vs Frequency in different voltage profile
<img width="960" alt="7" src="https://user-images.githubusercontent.com/35787202/126766974-c28744d7-06e3-438d-9074-d5d207d5a0ac.png">
Figure 7 Input Current Vs frequency in different voltage profile
<img width="960" alt="8" src="https://user-images.githubusercontent.com/35787202/126767059-e78a76b4-d40f-45bb-8704-c27fb2764279.png">
Figure 8 Input Power(Watt) Vs Frequency for different voltage profile
<img width="960" alt="9" src="https://user-images.githubusercontent.com/35787202/126767121-0d8bf7a6-8110-4879-9a7a-6c483c2e07fa.png">
Figure 9 Output Power(Watt) Vs Frequency for different voltage profile

Figure 4 shows efficiency performance for linear, quadratic, optimum and semi optimum profile. It is evident that semi optimum profile gives high efficiency in all frequency
range.  Figure 6 shows that pure optimum profile gives good power factor performance. Figure 7 shows input current drawn in all profile. Fig.8 and Fig .9 shows input and
output power. 
Though pure optimum gives high power factor performance, we shall use semi optimum profile for it`s higher efficiency performance in all frequency range. 
We have changed Kp`s value 50 percent above and 50 percent  below its rated value and found out that relative performance of all four-voltage profile keeps same.
So, we are confident that semi optimum profile is best suited for our application due to its superior efficiency performance in all frequency range..















