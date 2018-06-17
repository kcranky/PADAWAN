% Effects for audio

%% Run This First!
load train

%% Overdrive
tic();
yOut = y;
limit = 0.2;
val = 0.5;
count=0;
for t = 1:length(yOut)
    count=count+1;
    if(yOut(t)>limit)
        yOut(t)=val;
    end
    if(yOut(t)<-limit)
        yOut(t)=-val;
    end
end
sound(yOut,Fs);
toc()/count

%% ECHO
d1 = floor(Fs/2);
d2 = floor(Fs/2.1);
d3 = floor(Fs/2.2);

yOut = [zeros([d1+1, 1]);y];
for t = (d1+1):length(y)
    yOut(t) = y(t) + 0.5*y(t-d1) + 0.5*y(t-d2) + 0.5*y(t-d3);
    yOut(t)=yOut(t)/5;
end
sound(yOut,Fs);

%% Delay
d1 = floor(Fs/1);
yOut = [y; zeros([3*d1 1])];
for t = (d1+1):length(yOut)
    yOut(t) = yOut(t)+0.5*yOut(t-d1); %Note: based on previously computed yOut
end
sound(yOut,Fs);

%% Tremelo
yOut = y;
rate = 5; %in Hz
amplitude = 0.5;
for t = 1:length(yOut)
    yOut(t) = y(t)*(1+amplitude*cos((2*pi*rate/Fs)*t));
end
sound(yOut,Fs);