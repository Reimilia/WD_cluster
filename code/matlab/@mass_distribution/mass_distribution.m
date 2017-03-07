classdef mass_distribution
    %MASS_DISTRIBUTION �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        dim
        sample_size
        % ��һ����һ�� dim*size �ľ��� ����ÿ��Ϊһ����
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

