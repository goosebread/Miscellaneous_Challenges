%Alex Yeh
%2/10/2021

%A program investigating the validity of using the arithmetic mean instead
%of geometric mean for the center frequency of bandpass filters

%Created in response to a challenge to "figure it out yourself"
%posed by Dr. Farhat for EECE 4574

clear all;
clc;

nS=1000;%sample q factors
nF=100;%sample freq

f=logspace(5,10,nF);%frequencies
Q=logspace(1,6,nS);%Q factors

%sample frequencies to test
f1=50e6;%50MHz 
f2=9e6;%9MHz, mfjcub
f3=108e6;%108MHz FM station 

E=zeros(nF,nS);%error in hz
Ep=zeros(nF,nS);%error as percent of center f
for i=1:nF
    for j=1:nS
        E(i,j)=getError(f(i),f(i)/Q(j));
        Ep(i,j)=E(i,j)/f(i)*100;
    end
end
    

figure
mesh(Q,f,E);
set(gca,'XScale','log');
set(gca,'YScale','log');
ylabel("f (Hz)");
xlabel("Q factor");
zlabel("error (Hz)");


figure
mesh(Q,f,Ep);
set(gca,'XScale','log');
set(gca,'YScale','log');
ylabel("f (Hz)");
xlabel("Q factor");
zlabel("error (%)");

figure
semilogx(Q,E(1,:))
xlabel("Q");
ylabel("error (Hz)");

%inputs are center frequency (center on linear scale) and bandwidth
%returns error from center calculated using geometric mean of 
%upper and lower cutoff frequencies
function e=getError(center,bw)

    fu=center+bw/2;
    fl=center-bw/2;
    gm=sqrt(fu*fl);
    
    %I don't really care about errors less than 0.001 Hz
    %honestly I don't even need this part
    if abs(center-gm)<0.001
        e=0;
    else
        e=center-gm;
    end
end