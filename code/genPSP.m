% Function that generates a PSP - can use parameters to change behavior
function PSP = genPSP(t,sign,type)
% sign: 1 = positive (EPSP), 0 = negative (IPSP)
% type 1 = gaussian, 2 = log normal 

switch type
    case 1 % gaussian
        %Gaussian Distribution function: 
        a = 3; % controls height of curve
        b = 4; % controls location of center peak
        c = 1; % controls width of peak

        EPSP = a.*exp((-(t-b).^2)./(2.*c.^2));
        IPSP = -0.5*EPSP;
        
        if sign == 1 % epsp
            PSP = EPSP;
        else
            PSP = IPSP;
        end
        
    case 2 % log normal
        % Define parameters - these parameters give the best shape
        sigma = 0.5; % sigma must be > 0;
        mu = 0; % mu should be b/w -inf, inf

        EPSP = 1./(t.*sigma.*(sqrt(2.*pi))).*exp(-(log(t - mu).^2)./(2.*sigma.^2));

        % Scale vector 10mV max
        scale_factor = 10; %defines max amplitude in MicroVolts
        EPSP = EPSP*scale_factor; 

        % Generates IPSP pulse - 1/2 magnitude of EPSP and upside down
        IPSP = -0.5*EPSP;
        
        if sign == 1 % epsp
            PSP = EPSP;
        else
            PSP = IPSP;
        end
end

end
