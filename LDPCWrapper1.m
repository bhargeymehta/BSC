% plots the pSuccess v/s the p of BSC

% we first need to load the HMatrix
N = length(HMat(1, :));

sampleSize = 50;
p = linspace(0.01, 0.99, 99);
expRes = zeros(1, sampleSize);
graphData = zeros(1, length(p));

% the outer loop runs for each value of p ie 0.01, 0.02 to 0.99
for pError=1:length(p)
    
    % the inner loop performs the experiment for each value of p
    for i=1:sampleSize
        noise = randsrc(1, N, [1 0; p(pError) 1-p(pError)]);
        
        % we send the all zero codeword
        sentCodeword = zeros(1, N);
        
        % we then introduce the noise and send the noise affected codeword
        % to be decoded
        noiseAffected = rem(sentCodeword + noise, 2);
        [correctedCodeword, isValid, ] = decoderBSC(HMat, noiseAffected, 25, p(pError));
        
        % we store the result of the experiment in expRes
        if(isValid == 1 & sentCodeword == correctedCodeword)
            expRes(i) = 1;
        else
            expRes(i) = 0;
        end
    end
    
    % we store the pSuccess for a given value of p in its corresponding
    % array location in the array graphData
    graphData(pError) = sum(expRes)/sampleSize;
end

str = strcat('N=', num2str(N), ' || Sample Size=', num2str(sampleSize));
figure(1);
plot(p, graphData);
title('BSC Decoder Performance for LDPC Code');
xlabel('Probability p of BSC'); ylabel('Probability of Successful Decoding');
legend(str); grid;