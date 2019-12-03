function [edglst]=Create_epsilonball_graph(dat,K,ep)
% builds graph from data using epsilon ball rule. Basically, a node is
% connected to every point within a radius= epsilon

%INPUT: dat=data matrix [n x d] : n points in R^d
%K= number of nearest neighbors to use (for speed in narrowing the search
%of the local neighborhood)
%ep: neighborhood radius. Each point is connected to each point less than 
% ep away, in euclidean distance

%OUTPUT: UNDIRECTED edge list [#edges x 3]. E.g. row [i j d] means that j is a
%nearest neighbor of i. The edge should e repeated later in the list. d is the distance
%along that edge
%example values:
% K=16;
% ep=0.15;
M=size(dat,1);
[N, dist]=knnsearch(dat,dat,'K',K+1,'NSMethod','kdtree','Distance','Euclidean');%NOTE: nearest neighbor sets are not necessarily symmetric
N=N(:,2:end); %first col is each point itself
dist=dist(:,2:end); 
if sum(dist(:,K)>=ep)<size(dat,1)%if the farthest neighbor is not on/outside the ball for every ball
    disp('K not large enough relative to epsilon. Epsilon ball may contain neighbors that are not listed in N')
    return
end

%
edglst=[];
for j=1:size(dat,1)
    new=[j*ones(1,sum(dist(j,:)<ep,2)); N(j,dist(j,:)<ep); dist(j,dist(j,:)<ep)]';%[current node ID repeated as many times as there are contacts in the ball [1xn];
    edglst=[edglst; new];                                                                                               %IDs of connected nodes [1xn];
end                                                                                                                                      %distances to connected nodes[1xn]]
end