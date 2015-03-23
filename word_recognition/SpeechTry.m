function  [I,TEST_SMOOTHED ,Matched ]=SpeechTry()

UP = wavread('UP.wav');
DOWN = wavread('DOWN.wav');
LEFT = wavread('LEFT.wav');
RIGHT = wavread('RIGHT.wav');
%----------------------------------------------------------------------
fs = 11025;
TEST = wavrecord(5*fs,fs);
TEST_SMOOTHED =  EndPointing(TEST); 
UP =  EndPointing(UP); 
DOWN =  EndPointing(DOWN); 
RIGHT =  EndPointing(RIGHT); 
LEFT =  EndPointing(LEFT); 
wavplay(TEST_SMOOTHED,fs);
%TEST_SMOOTHED = wavread('T.wav');



FeatureVectorsUP =calculate_mfcc(UP);
FeatureVectorsDOWN =calculate_mfcc(DOWN);
FeatureVectorsRIGHT =calculate_mfcc(RIGHT);
FeatureVectorsLEFT =calculate_mfcc(LEFT);

FeatureVectorsT =calculate_mfcc(TEST_SMOOTHED);

[F , T]=size(FeatureVectorsT);
[F , SU]=size(FeatureVectorsUP);
[F , SD]=size(FeatureVectorsDOWN);
[F , SU]=size(FeatureVectorsUP);
[F , SL]=size(FeatureVectorsLEFT);
[F , SR]=size(FeatureVectorsRIGHT);
M = [T,SU,SD,SR,SL];
[M,I] = max(M);

NFeatureVectorsT = zeros(F,M);
NFeatureVectorsUP = zeros(F,M);
NFeatureVectorsDOWN = zeros(F,M);
NFeatureVectorsLEFT = zeros(F,M);
NFeatureVectorsRIGHT = zeros(F,M);

NFeatureVectorsT(1:F,1:T)=FeatureVectorsT;
NFeatureVectorsUP(1:F,1:SU)=FeatureVectorsUP;
NFeatureVectorsDOWN(1:F,1:SD)=FeatureVectorsDOWN;
NFeatureVectorsLEFT(1:F,1:SL)=FeatureVectorsLEFT;
NFeatureVectorsRIGHT(1:F,1:SR)=FeatureVectorsRIGHT;


DUP =DTW(NFeatureVectorsT,NFeatureVectorsUP);
DDOWN =DTW(NFeatureVectorsT,NFeatureVectorsDOWN);
DRIGHT =DTW(NFeatureVectorsT,NFeatureVectorsRIGHT);
DLEFT =DTW(NFeatureVectorsT,NFeatureVectorsLEFT);

M = [DUP,DDOWN,DRIGHT,DLEFT];
[A,I] = min(M);
if(I==1)
Matched = UP;
end
if(I==2)
Matched = DOWN;
end
if(I==3)
Matched = RIGHT;
end
if(I==4)
Matched = LEFT;
end
end