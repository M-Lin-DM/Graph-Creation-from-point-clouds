function [inds, edglst]=Create_Lattice_Network_2D(XX)
% Generate Latice Network from Meshgrid
%INPUT: NxM matrix that is one of the outputs of meshgrid 
%OUTPUT: edglst: edgelist (numbers are node ID from inds) 
%inds:  indicies of each point in edglist reshaped as the output of meshrid
%so that ind(i,j) = index of the corresponding grid point in the meshgrid

%in other words, lattice points are labeled by their linear index within XX
% [XX, YY]=meshgrid(1:20,1:20);
inds=reshape(1:numel(XX),size(XX,1),size(XX,2));%this matrix shows node IDs of each lattice point (ID equals linear index)
% create edgelist
edglst=[];
for j=1:size(XX,2)-1
    edglst=[edglst; inds(:,j:j+1)];
end
for i=1:size(XX,1)-1
    edglst=[edglst; inds(i:i+1,:)'];
end
edglst=[edglst, ones(length(edglst),1)];
%

end