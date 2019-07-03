% function which takes the decision for the bit that
% is under consideration about whether or not the bit is to be flipped

function changeRequired=iterationResult(recievedCodeword, HMat, bit2check)
rowSize = length(HMat(1, :));
colSize = length(HMat(:, 1));

dv=0;

% problem variable counts the number of votes in favour of flipping the bit
problem = 0;

% the loop runs for each check node
for i=1:colSize
    
    % if the HMatrix check node has 1 in the same index as the index of the
    % bit in the codeword then we know that the given bit node is part of
    % the parity check relation which is reprsented by the i-th parity
    % check relation
    if(HMat(i, bit2check)==1)
        
        % temp is counting whether the parity is odd or even
        temp = 0;
        
        % dv stores the number of checknodes the bit node is connected to
        dv = dv + 1;
        
        % for given parity relation, except the bit that is to be checked
        % we sum all the bit positions that have 1 in the parity check
        % matrix
        % so finally temp stores the sum of all the bit nodes except the
        % one in consideration connected to one check node
        for j=1:rowSize
            if(j~=bit2check && HMat(i, j)==1)
               temp = temp + recievedCodeword(j); 
            end
        end
        
        % we then convert temp to modulo-2 so that we can find what the bit
        % should actually be if the rest of the bits are assumed to be
        % correct
        temp=rem(temp, 2);
        
        % if the bit agrees with the check node decision, then we do
        % nothing else we count the vote of this check node by incrementing
        % the problem variable
        if(temp~=recievedCodeword(bit2check))
            problem = problem + 1;
        end
        
    end
    
end

% if strict majority of the check nodes decide for flipping the value then
% we pass 1 else 0
if(problem>dv/2)
    changeRequired = 1;
else
    changeRequired = 0;
end

end