function errors = errors(x)

global stal modelYears lastPreBomb

modelStal = calc4box(fluxes(x));
modelStal = horzcat(modelYears, modelStal);

test = stal(lastPreBomb+1:end,:);

y = zeros(length(test), 1);

for i = 1:1:length(y)
    y(i) = find(modelStal(:,1)==round(test(i,1)));
end

errors = zeros(length(y),1);

for i = 1:1:length(y)
    errors(i) = test(i,2) - modelStal(y(i),2);
end

errors = sqrt(sum((errors).^2));
