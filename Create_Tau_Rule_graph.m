function [edglst]=Create_Tau_Rule_graph(dat,tau)
% builds graph from data using tau rule
%INPUT: dat=data matrix [n x d] : n points in R^d
%tau = positive number >= 1

%OUTPUT: UNDIRECTED edge list [#edges x 3].  d is the distance
%(used as edge weight) along that edge
K=1;%do not alter!
[N, dist]=knnsearch(dat,dat,'K',K+1,'NSMethod','kdtree','Distance','Euclidean');%NOTE: nearest neighbor sets are not necessarily symmetric
N=N(:,2:end); %index of each point's nearest neighbor. first col is each point itself
dist=dist(:,2:end); %distance to each point's nearest neighbor
edglst=[];
M=size(dat,1);

for u=2:M
    for v=1:u-1
        if (dist(u)<=tau*dist(v))&&(dist(v)<=tau*dist(u))
            if (norm(dat(u,:)-dat(v,:))<=tau*dist(u))||(norm(dat(u,:)-dat(v,:))<=tau*dist(v))
               edglst=[edglst; u, v, norm(dat(u,:)-dat(v,:))];
            end
        end
    end
end
% line([dat(edglst(:,1),1)'; dat(edglst(:,2),1)'], [dat(edglst(:,1),2)'; dat(edglst(:,2),2)'], 'color', 'k');

end