%% create graphs based on different rules, but using the same initial dataset
%create sample data:
dat=rand(300,2);
dat(:,1)=dat(:,1)-0.2*sin(dat(:,1)*25); dat(:,2)=dat(:,2)-0.1*sin(dat(:,2)*20);
plot(dat(:,1), dat(:,2), 'k.'); axis equal
% dat=load('dat'); dat=dat.dat; %import this data to compare the different graph creation rules 
%% tau rule graph
tau=linspace(1,3,3);
for j = 1:3
    j
    clear edglst
edglst=Create_Tau_Rule_graph(dat,tau(j));
subplot(1,3,j)
plot(dat(:,1),dat(:,2),'bo','markersize', 4)
hold on
line([dat(edglst(:,1),1)'; dat(edglst(:,2),1)'], [dat(edglst(:,1),2)'; dat(edglst(:,2),2)'], 'color', 'k'); axis square
title(['\tau = ' num2str(tau(j))], 'fontsize', 14)
end
%% Epsilon ball graph
ep=linspace(0.05,0.1,3);
K=100;
for j = 1:3
    j
    clear edglst
edglst=Create_epsilonball_graph(dat,K,ep(j))
subplot(1,3,j)
plot(dat(:,1),dat(:,2),'bo','markersize', 4)
hold on
line([dat(edglst(:,1),1)'; dat(edglst(:,2),1)'], [dat(edglst(:,1),2)'; dat(edglst(:,2),2)'], 'color', 'k'); axis square
title(['\epsilon = ' num2str(ep(j))], 'fontsize', 14)
end
%% KNN graph
K=[1,3,5];
for j = 1:3
    j
    clear edglst
edglst=Create_KNN_graph(dat,K(j))
subplot(1,3,j)
plot(dat(:,1),dat(:,2),'bo','markersize', 4)
hold on
line([dat(edglst(:,1),1)'; dat(edglst(:,2),1)'], [dat(edglst(:,1),2)'; dat(edglst(:,2),2)'], 'color', 'k'); axis square
title(['K = ' num2str(K(j))], 'fontsize', 14)
end
%% generate 2D rectangular lattice network
intr=[0.05, 0.1, 0.2];

for j = 1:3
    j
    clear edglst
    [XX YY]=meshgrid(0:intr(j):1,  0:intr(j):1);
    dat2=[XX(:), YY(:)];
    [inds, edglst]=Create_Lattice_Network_2D(XX)
    subplot(1,3,j)
    plot(dat2(:,1),dat2(:,2),'bo','markersize', 4)
    hold on
    line([dat2(edglst(:,1),1)'; dat2(edglst(:,2),1)'], [dat2(edglst(:,1),2)'; dat2(edglst(:,2),2)'], 'color', 'k'); axis square
    title(['int = ' num2str(intr(j))], 'fontsize', 14)
end