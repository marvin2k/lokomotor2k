%%
% @brief Berechnung der vereinfachten n*c1*sin(c2*n+t) Koeffizienten bei gegebener Winkelverlaufsmatrix
%
% Verwendet eine Fitnessfunktion um die beiden Koeffizienten zu bestimmen, die nicht kompatibel zu Matlab ist...
% zur funktion sollte "sudo apt-get install octave-optim" ausgeführt werden
%
% @param alpha_M Matrix aller Gelenkwinkel über eine Bewegungsseqeunz, könnte zum Beispiel von einer Minimierungsfunktion zur Anpassung an eine berechnete Schwanzform stammen
%
% @return c1
% @return c2
%
%%
function [c1 c2] = fit_emulation_coeffs( alpha_M );

    % Das hier ist eigentlich nur eine Wrapperfunktion.
    emulation_coeffs_v = fminsearch(@funfun,[0.1 1],[],[],alpha_M);
    c1 = emulation_coeffs_v(1);
    c2 = emulation_coeffs_v(2);


function out=funfun(coeff,alpha_M)
% Step back, pure magic!!!
a = coeff(1);
b = coeff(2);

t = linspace(0,2*pi,length(alpha_M));

    for nr = 0:5
        y_fun(:,nr+1) = nr*a*sin( nr*b - t*2*pi  );
    end

diff_M = y_fun - alpha_M; 
diff_v = sum(diff_M);
diff = sum(diff_v);

sq_diff = diff.^2;
out = sum(sq_diff);
end
