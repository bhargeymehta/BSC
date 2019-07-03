% plots the number of error v/s the pSuccess of the BSC
clear vars; clear all;

% makes the required matrices to operate on
rootK = 2;
k=rootK*rootK;
N=(rootK+1).^2;
[HMat, codeWords] = productCodeBasics(rootK);

% we will introduce 1 bit of error (sampleSize) times and check the
% probability of success, then we will introduce 2 bits  
% of error (sampleSize) times and so on till N
sampleSize=5000;
decodingSuccess = zeros(1, N);

% we will introduce error in 1, 2....N bits
for nError=1:N
    expRes = zeros(1, sampleSize);
    
    % for the given number of errors, we will conduct an experiment
    % sampleSize times to decide the probability of success for the given
    % probability p defined by outer loop
    for j=1:sampleSize
        
        % logic to introduce random errors to pre-defined number of bits
        temp = randperm(N, nError);
        noiseError = zeros(1, N);
        for i=1:nError
            noiseError(temp(i))=1;
        end
        
        % infecting the sent codeword with noise
        codewordSent = codeWords(randperm(2.^k, 1), :);
        noiseAffected = rem(codewordSent + noiseError, 2);
        
        % we record the result of experiment in pBits
        [correctedCodeword, isValid, ] = decoderBSC(HMat, noiseAffected, 50, nError/N);
        
        if(correctedCodeword == codewordSent)
            expRes(j) = 1;
        else
            expRes(j) = 0;
        end
    end
    
    % we store the pSuccess for the given value of p in its correspinding
    % position in the decodingSuccess array
    expRes = sum(expRes)/sampleSize;
    
    decodingSuccess(nError)=expRes;
end

str = strcat('k= ', num2str(k), ' N=', num2str(N), ' || sampleSize=', num2str(sampleSize));
figure(2);
stem(linspace(1, N, N), decodingSuccess); ylim([0 1]);
xlabel('No. of Bits having Errors'); ylabel('Probability of Successful Decoding');
legend(str);
title('Performance of Product Code in BSC'); grid;