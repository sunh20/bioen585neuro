function dydt = simpleIZ(t,y,params)

v = y(1);
u = y(2);
I = params(1);
a = params(2);
b = params(3);
c = params(4);
d = params(5);
maxSpike = params(6);

if v >= maxSpike
    v = c;
    u = u + d;
end
    
dydt(1) = 0.04*v^2 + 5*v + 140 - u + I;
dydt(2) = a * (b*v - u); 

end