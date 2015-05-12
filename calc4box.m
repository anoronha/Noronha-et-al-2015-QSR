function [modelStal, dcpLim] = calc4box(x)

%calc2box models stalagmite 14C using a box model that uses correct fluxes 
%The intial value of the pools is set to the average of the atmospheric 14C
%over the current time minus one turnover time.  
 
global atmo stal startModel modelYears lastPreBomb memoMeans lambda

pool1 = memoMeans(x(5));
pool2 = memoMeans(x(6));
pool3 = memoMeans(x(7));
pool4 = memoMeans(x(8));

pool1Rec = zeros(length(modelYears),1);
pool2Rec = zeros(length(modelYears),1);
pool3Rec = zeros(length(modelYears),1);
pool4Rec = zeros(length(modelYears),1);

modelGas = zeros(length(modelYears),1);

pool1Rec(1) = ((pool1*(1-(1/x(5)))))+((1/x(5))*atmo(startModel,2));
pool2Rec(1) = ((pool2*(1-(1/x(6)))))+((1/x(6))*atmo(startModel,2));
pool3Rec(1) = ((pool3*(1-(1/x(7)))))+((1/x(7))*atmo(startModel,2));
pool4Rec(1) = ((pool4*(1-(1/x(8)))))+((1/x(8))*atmo(startModel,2));

modelGas(1) = x(1)*pool1Rec(1)+x(2)*pool2Rec(1)+x(3)*pool3Rec(1)+x(4)*pool4Rec(1);
 
for i = 2:1:(length(modelYears))
    pool1Rec(i) = ((pool1Rec(i-1)*(1-(1/x(5)))))*exp(-lambda)+((1/x(5))*atmo(startModel-i+1,2));
    pool2Rec(i) = ((pool2Rec(i-1)*(1-(1/x(6)))))*exp(-lambda)+((1/x(6))*atmo(startModel-i+1,2));
    pool3Rec(i) = ((pool3Rec(i-1)*(1-(1/x(7)))))*exp(-lambda)+((1/x(7))*atmo(startModel-i+1,2));
    pool4Rec(i) = ((pool4Rec(i-1)*(1-(1/x(8)))))*exp(-lambda)+((1/x(8))*atmo(startModel-i+1,2));    
    modelGas(i) = x(1)*pool1Rec(i)+x(2)*pool2Rec(i)+x(3)*pool3Rec(i)+x(4)*pool4Rec(i);
end

modelGas = horzcat(modelYears, modelGas);

r = zeros(lastPreBomb,1);

for i = 1:1:lastPreBomb
    r(i) = find(round(stal(i,1))==modelGas(:,1));
end

modelGas = modelGas(:,2);

dcpLim = zeros(lastPreBomb, 2);

for i = 1:1:lastPreBomb
    dcpLim(i,1) = modelGas(r(i),1);
    dcpLim(i,2) = stal(i,2);
end

dcpLim = mean(dcpLim(:,1)-dcpLim(:,2));
if dcpLim < 0; 
    dcpLim = 0;
end
 
modelStal = modelGas-dcpLim;