function x = fluxes(x)

for i = 1:1:4
    y(i) = x(i)/round(x(i+4));
end

for i = 1:1:4
    z(i) = y(i)/sum(y);
end

x = vertcat(z',round(x(5:8)));