load('mds24.mat','Y','labels','index','Dist','N','DN');

for i=1:DN
    Dist(i,i)=0;
end
for i=1:DN
    for j=i+1:DN
        Dist(i,j)=0.5*(Dist(i,j)+Dist(j,i));
        Dist(j,i)=Dist(i,j);
    end
end
Y=mdscale(Dist,3,'Criterion','metricstress');
%Y=cmdscale(Dist,2);
%index=subindex(1:N);
%save('mds.mat,'Y','index','Dist','N','DN');

%MDS×÷Í¼
figure(1);
hold on;

x=Y(N+1:DN,1);
y=Y(N+1:DN,2);
z=Y(N+1:DN,3);
scatter3(x,y,z,50,'filled');
for i=1:4
    sc=25;
    x=Y(find(labels==i),1);
    y=Y(find(labels==i),2);
    z=Y(find(labels==i),3);
    scatter3(x,y,z,sc,'filled');
end
hold off;