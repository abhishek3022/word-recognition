function   N_signal = silince_noise_remove (O_signal)

frame_duration = 0.025;
Fs = 11025;
frame_len = frame_duration*Fs;
N = length(O_signal);
num_frames = floor(N/frame_len);
C = 0;
%N_signal = zeros(N,1);

%filter the noise
[b,a]=butter(2,0.3,'low');
O_filered = filter(b,a,O_signal);

%step-1 break the signal into frames of 0.01 sec
for i=1:num_frames
    
    %extract frame from signal
    frame = O_filered((i-1)*frame_len+1 : frame_len*i);

    %identify speech by fiding frames with max amplitude more than 0.03
    Max_amp = max(frame);    
    if(Max_amp > 0.5)
        C = C+1;
        %create a new signal with no silence
        N_signal((C-1)*frame_len+1 : frame_len*C) = frame;
    end
end
wavplay(N_signal,11025);
%figure,plot(N_signal)
%figure,plot(O_signal)
end