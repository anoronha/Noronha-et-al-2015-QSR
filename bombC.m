format shortG

'running model'
timeStart = cputime;
warning('off', 'MATLAB:nearlySingularMatrix')

clear atmo stal lambda x0 startRecord lastPreBomb stalYears intPool memoMeans startModel modelYears

global atmo stal lambda startRecord lastPreBomb stalYears intPool memoMeans startModel modelYears

%input values here:
%-----------------------------------------------------------------------%
in_stal = load('heshang.txt');
postbomb = load('NHZ3.txt');
prebomb = load('nhprebomb.txt');
guesses = 10;
windup = 100;
%-----------------------------------------------------------------------%

atmo = vertcat(postbomb, prebomb);

stal = sortrows(in_stal,-1);

lambda = log(2)/5730;

for i = 1:1:length(stal);
    stal(i,2) = stal(i,2)*exp(-stal(i,1)*lambda);
end

stalYears = (round(stal(1,1)):-1:-60)';
modelYears = (windup+round(stal(1,1)):-1:-60)';

x0 = [1/4 1/4 1/4 1/4 0 0 0 0]';

lastPreBomb = find(stal(:,1)>-5, 1, 'last');

startRecord = find(atmo(:,1)==round(stal(1,1)));

startModel = startRecord+windup;

intPool = zeros(length(atmo),1);

for i = 1:1:length(atmo)-startModel
    intPool(i) = atmo(startModel+i,2)*exp(-(lambda*atmo(startModel+i,1)));
end

memoMeans = zeros(10000,1);
for i = 1:1:length(memoMeans)
    memoMeans(i) = mean(intPool(1:i));
end

Aeq = [1 1 1 1 0 0 0 0];
beq = 1;

A = [-1 0 0 0 0 0 0 0;...
     0 -1 0 0 0 0 0 0;...
     0 0 -1 0 0 0 0 0;...
     0 0 0 -1 0 0 0 0;...
     0 0 0 0 -1 0 0 0;...
     0 0 0 0 0 -1 0 0;...
     0 0 0 0 0 0 -1 0;...
     0 0 0 0 0 0 0 -1];

b = [0; 0; 0; 0; 0; 0; 0; 0];

lb = [0 0 0 0 1 2 100 1000];
ub = [1 1 1 1 1 99 999 10000];

opts = optimset('Algorithm','interior-point','FunValCheck', 'on','UseParallel','always');

problem = createOptimProblem('fmincon','x0',x0,...
    'objective',@errors,'lb',lb,'ub',...
    ub, 'Aineq', A, 'bineq', b, 'Aeq', Aeq,...
    'beq', beq,'nonlcon',@nonlcon,'options',opts);

ms = MultiStart('StartPointsToRun', 'bounds');

[xming,fming,flagg,outptg,manymins] = run(ms,problem,guesses);

numSolutions = length(manymins);

solutions = horzcat(xming', fming);

for i = 2:1:numSolutions
    solutions = vertcat(solutions, horzcat(manymins(1,i).X',manymins(1,i).Fval));
end

truncSolutions = horzcat(solutions(:,1:4), round(solutions(:,5:8)));

modelSolutions = 1950-modelYears;

for i = 1:1:length(truncSolutions)
    modelSolutions = horzcat(modelSolutions, calc4box(fluxes(truncSolutions(i,:)')));
end

bestFitSOM = horzcat(round(solutions(1,1:4)*100),round(solutions(1,5:8)));
bestFitFluxes = fluxes(solutions(1,1:8)')';
bestFitFluxes = horzcat(round(bestFitFluxes(1:4)*100),round(bestFitFluxes(5:8)));

params  = horzcat(bestFitSOM(1:4)', bestFitFluxes(1:4)', bestFitFluxes(5:8)');

evalc('printmat(params, '''' , ''1 2 3 4'' , ''P F tau'')')


figure('Color',[1 1 1])
hold on
set(gcf,'Position', [200, 100, 1049, 895]);
set(gca,'FontSize', 24,'Units','Normalized','Linewidth',3)
axis([1940 2015 50 200])
xlabel('Calendar Age (Years AD)');
ylabel('^{14}C (pMC)');

plot((1950-(atmo(1:100,1))), atmo(1:100,2)*100, 'k-', 'LineWidth', 3)

for i = 1:1:length(truncSolutions)
    plot(modelSolutions(:,1),modelSolutions(:,i+1)*100, 'Color', [0.5 0.5 0.5])
end

plot (modelSolutions(:,1),modelSolutions(:,2)*100, 'r-','LineWidth',3)
errorbar(1950-stal(:,1), stal(:,2)*100, stal(:,3)*100, '.k', 'MarkerSize', 20);
shg

% warning('on', 'MATLAB:nearlySingularMatrix')
timeElapsed = cputime - timeStart

