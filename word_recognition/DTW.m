
% dynamic time warping of two signals

function totalDistance=DTW(signal,template)


signalSize=size(signal,1);
templateSize=size(template,1);
if signalSize > 2*templateSize || templateSize > 2*signalSize
    error('Error in dtw(): the length difference between the signals is very large.');
end

%% initialization
distances=zeros(signalSize,templateSize)+Inf; % c3ache matrix

distances(1,1)=norm(signal(1,:)-template(1,:));
%initialize the first row.
for j = 2:templateSize
    cost = norm(signal(1,:)-template(j,:));
    distances(1,j) = distances(1,j-1) + cost;
end
%initialize the first column.
for i = 2:signalSize
    cost = norm(signal(i,:)-template(1,:));
    distances(i,1) = cost+ distances(i-1,1);
end

%initialize the second row.
for j = 2:templateSize
    cost = norm(signal(2,:)-template(j,:));
    %distances(i,j)=cost+min( [      LEFT      ,      CORNER     ] );
     distances(2,j)=cost+min( [distances(2,j-1), distances(1,j-1)] );
end

%% begin dynamic programming
for i=3:signalSize
    for j=2:templateSize
        cost=norm(signal(i,:)-template(j,:));
        %distances(i,j)=cost+min( [ LEFT           , CORNER            , FAR_CORNER        ] );
         distances(i,j)=cost+min( [distances(i,j-1), distances(i-1,j-1), distances(i-2,j-1)] );
    end
end
totalDistance=distances(signalSize,templateSize);
end
