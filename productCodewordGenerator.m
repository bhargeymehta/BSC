%generates the codeword of particular index

function y=productCodewordGenerator(rootK, codeNumber)

% logic that converts a decimal number (0, 1, ....) to binary which acts as
% the data bits
tempCodes = zeros(rootK+1, rootK+1);
for i=1:rootK
   for j=1:rootK 
      tempCodes(rootK+1-i, rootK+1-j) = rem(codeNumber, 2);
      codeNumber = fix(codeNumber/2);
   end
end

% logic that sets the row and column parities simultaneously
% i denotes the ith row/column
for i=1:rootK
    temp=0; %setting row parities
    for j=1:rootK
        temp = temp + tempCodes(i, j);
    end
    tempCodes(i, rootK+1) = rem(temp, 2);
    
    
    temp=0; %setting column parities
    for j=1:rootK
        temp = temp + tempCodes(j, i);
    end
    tempCodes(rootK+1, i) = rem(temp, 2);
    
end

% parity for the corner bit
temp = 0;
for i=1:rootK
    temp = temp + tempCodes(i, rootK+1);
end
tempCodes(rootK+1, rootK+1) = rem(temp, 2);

y = zeros(1, (rootK+1).^2);
% makes the encoded codeword linear by appending each row after another
for i=1:rootK+1
    y(1+(rootK+1)*(i-1):(rootK+1)*i) = tempCodes(i, :);
end

end