% this function does the decoding with the help of iterationResult function

function [correctedCodeword, completedDecoding, iterationsDone] = decoderBSC(HMat, recievedCodeword, fullLimit, prob)
rowSize = length(HMat(1, :));

% we first flip all the bits if we find that the probabiliy p of BSC is
% >0.5 so that effect is nullified and most bits are actually unflipped now

if(prob>0.5)
    recievedCodeword = rem(recievedCodeword+1, 2);
end

% we make a copy of the codeword to make changes to
correctedCodeword = recievedCodeword;

iterationsDone = 0;

% this loop runs for as many interations as we want. the loop breaks using
% a condition containing the break statement if we find a valid codeword,
% but if the algorithm is stuck and is not able to decode then we have to
% stop it after some pre-defined number of iterations which we are calling
% fullLimit here
for fullCycle=1:fullLimit
    
    % we do the iteration result for every bit in the codeword
    for i=1:rowSize
        
        % we do the voting about the flipping of the bit and document this
        % iteration
        shouldChange = iterationResult(correctedCodeword, HMat, i);
        iterationsDone = iterationsDone + 1;
        
        % if the voting decides that bit should be reversed then it is
        % reversed else nothing happens
        if(shouldChange == 1)
            correctedCodeword(i) = rem(correctedCodeword(i)+1, 2);
            %fprintf('Check Fail at checkNode: %d in cycle: %d\n', i, fullCycle);
        end
        
        % after each iteration we see whether the updated codeword is a
        % valid codeword or not. if it is then we break out the process
        % else we continue
        completedDecoding = 1;
        for j=1:rowSize
            if(iterationResult(correctedCodeword, HMat, j)==1)
                completedDecoding = 0;
                break;
            end
        end
        
        % break statement to break from inner loop
        if(completedDecoding == 1)
            break;
        end
        
    end
    
    % break statement to break from outer loop
    if(completedDecoding == 1)
        break;
    end
    
end

end