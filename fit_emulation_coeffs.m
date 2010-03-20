%%
% @brief Berechnung der vereinfachten n*c1*sin(c2*n+t) Koeffizienten bei gegebener Winkelverlaufsmatrix
%
% Verwendet eine Fitnessfunktion um die beiden Koeffizienten zu bestimmen, die nicht kompatibel zu Matlab ist...
% zur funktion sollte "apt-get install octave-optim" ausgeführt werden
%
% @param alpha_M Matrix aller Gelenkwinkel über eine Bewegungsseqeunz, könnte zum Beispiel von einer Minimierungsfunktion zur Anpassung an eine berechnete Schwanzform stammen
%
% @return c1
% @return c2
%
%%
function [c1 c2] = fit_emulation_coeffs( alpha_M );

    % Das hier ist eigentlich nur eine Wrapperfunktion.
    emulation_coeffs_v = fminsearch(@funfun,[0.001 1],[0 10^-6 0 0 0 0],[],alpha_M);
    c1 = emulation_coeffs_v(1);
    c2 = emulation_coeffs_v(2);


function out=funfun(coeff,alpha_M)
c1 = coeff(1);
c2 = coeff(2);

% eine einzige Stellung rauspicken, es macht keinen Sinn das für die ganze sequenz zu berechnen.
% Berechnungstrick ähnlich wie emulate_pose... zum Zeitpunkt t=0
idx = 0:5;
alpha_v = c1*idx.*sin(c2*idx);


diff = sum(alpha_M(1,:) - alpha_v)
out = diff^2;
end
