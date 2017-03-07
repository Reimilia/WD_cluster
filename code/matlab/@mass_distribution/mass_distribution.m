classdef mass_distribution
    %MASS_DISTRIBUTION 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        dim
        sample_size
        % 这一定是一个 dim*size 的矩阵 这样每列为一个点
        pos
        prob
        dist
    end
    
    methods
        function [obj]= mass_distribution(d,N,pos,prob,dist)
            obj.dim=d;
            obj.sample_size=N;
            obj.pos=pos;
            obj.prob=prob;
            obj.dist=dist;
        end
    end
    
end

