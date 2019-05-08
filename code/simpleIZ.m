function dydt = simpleIZ(t,y,params)

v = y(1);
u = y(2);
a = params{1};
b = params{2};
c = params{3};
d = params{4};
maxSpike = params{5};
tspan = params{6};
I = params{7};

dydt = zeros(2,1);

if v >= maxSpike
    disp('Max spike reached')
    v = c;
    u = u + d;
end

% get input value at this time
I_t = interp1(tspan,I,t);

dydt(1) = 0.04*v^2 + 5*v + 140 - u + I_t;
dydt(2) = a * (b*v - u); 

end