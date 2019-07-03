% makes the HMatrix and dictionary based on the value of rootK

function [HMat, CMat]=productCodeBasics(rootK)

HMat=zeros(2*rootK+1, (rootK+1).^2);

% exploits the property of HMatrix of product code that each row contains
% rootK+1 ones offset by rootK+1 so that first row is 1, 2, 3 
% second is 4, 5, 6 for k=4
for i=1:rootK
    for j=1:rootK+1
       HMat(i, (rootK+1)*(i-1)+j)=1; 
    end
end

% the remaining rows have the proprty of having ones separated by rootK
% zeros so that it becomes 1, 4, 7 and the rest are shifted to right
% towards one so 2, 5, 8 and 3, 6, 9
for i=1:rootK+1
   for j=1:rootK+1
      HMat(i+rootK, i+(rootK+1)*(j-1))=1; 
   end
end

% generates the codeword of a particular index
CMat = zeros(2.^(rootK*rootK), (rootK+1).^2);
for i=1:2.^(rootK*rootK)
   CMat(i,:) = productCodewordGenerator(rootK, i-1);
end

end