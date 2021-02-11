%Alex Yeh
%2/10/2021

%A program investigating the validity of using the arithmetic mean instead
%of geometric mean for the center frequency of bandpass filters

%Created in response to a challenge to "figure it out yourself"
%posed by Dr. Farhat for EECE 4574

%number of samples
nS=1000

%Q factor of filter
Q=logspace(1,6,nS);

%sample frequencies to test
f1=50e6;%50MHz 
f2=9e6;%9MHz, mfjcub
f3=108e6;%108MHz FM station 

%error arrays
e1=zeros(1,nS);
e2=e1;
e3=e1;

for i=1:nS
    e1(i)=getError(f1,f1/Q(i));
    e2(i)=getError(f2,f2/Q(i));
    e3(i)=getError(f3,f3/Q(i));
end

%errors as a percent of center frequency
ep1=e1./f1*100;
ep2=e2./f2*100;
ep3=e3./f3*100;


%plots
figure
semilogx(Q,e1)
ylabel("error (Hz)");
xlabel("Q factor");
title("50Mhz");

figure
semilogx(Q,e2)
ylabel("error (Hz)");
xlabel("Q factor");
title("9Mhz");

figure
semilogx(Q,e3)
ylabel("error (Hz)");
xlabel("Q factor");
title("108Mhz");

figure
semilogx(Q,ep1)
ylabel("error (%)");
xlabel("Q factor");
title("50Mhz");

figure
semilogx(Q,ep2)
ylabel("error (%)");
xlabel("Q factor");
title("9Mhz");

figure
semilogx(Q,ep3)
ylabel("error (%)");
xlabel("Q factor");
title("108Mhz");


%inputs are center frequency (center on linear scale) and bandwidth
%returns error from center calculated using geometric mean of 
%upper and lower cutoff frequencies
function e=getError(center,bw)

    fu=center+bw/2;
    fl=center-bw/2;
    gm=sqrt(fu*fl);
    e=center-gm;
end