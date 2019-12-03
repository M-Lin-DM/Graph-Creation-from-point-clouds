function [edglst]=Create_KNN_graph(dat,K)
% builds graph from data using k nearest neighbors rule
%INPUT: dat=data matrix [n x d] : n points in R^d
%K= number of nearest neighbors to use. Each point will be connected to its
%K nearest neighbors
%OUTPUT: DIRECTED edge list [#edges x 3]. E.g. row [i j d] means that j is a
%nearest neighbor of i, but not necessarily vice versa. d is the distance along that edge


[N, dist]=knnsearch(dat,dat,'K',K+1,'NSMethod','kdtree','Distance','Euclidean');%NOTE: nearest neighbor sets are not necessarily symmetric
N=N(:,2:end); %first col is each point itself
dist=dist(:,2:end); 
%
edglst=[];
for j=1:size(dat,1)
    new=[j*ones(1,K); N(j,:); dist(j,:)]';
    edglst=[edglst; new];
end

end