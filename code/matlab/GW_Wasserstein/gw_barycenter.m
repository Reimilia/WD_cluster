function [ output_args ] = gw_barycenter( samples, histogram ,lambda)

%Get a distance matrix for barycenter
%use KL divergence or L2 loss

N= length(samples);

M= length(histogram);

C=ones(M);

epsilon= 1;
loop_count=0;
while epsilon>=1e-2 && loop_count<=200
    
    for i=1:N
        eps=1;
        inner_loop_count=0;
        while eps>=1e-2 && inner_loop_count<=200
            
        end
    end
end

end

