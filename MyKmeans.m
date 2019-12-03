
function [ means, inds ] = MyKmeans(data, K, D)
%   mCluster  := K-means Clustering
%   N:= number of clusters

color = {'y.','m.','c.','r.','g.','b.','k.','rd'};

means = data(randsample(size(data,1),K),:);
figure, 
% plot3(data(:,1),data(:,2),data(:,3),'.')
% drawnow
hold on


iter = 1;
while(true)
    % expectation step
    for i=1:size(data,1)
        dist = zeros(K,1);
        for k=1:K
           dist(k) =  pdist2(data(i,:),means(k,:),D);
        end
        [~,inds(i)] = min(dist); 
    end
    prev_means = means;
    % maximization step
    for k=1:K
       means(k,:) = mean(data(inds==k,:),1); 
       plot3(data(inds==k,1),data(inds==k,2),data(inds==k,3),color{k})
    end
    
    disp(sum(sum(abs(prev_means-means))))
    if sum(sum(abs(prev_means-means))) < 0.0001
        break;
    end  
    iter = iter + 1
end

for k=1:K
   plot3(means(:,1),means(:,2),means(:,3),'kx','Markersize',12); 
   plot3(means(:,1),means(:,2),means(:,3),'ko','Markersize',12); 
end
hold off

end

