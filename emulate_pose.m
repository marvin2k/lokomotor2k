%%
% @brief Berechnung eines Vektors von Servowinkeln, welche eine Schwanzpose beschreiben. Kurvenschwimmen bereits eingebaut
%
% @param n Anzahl der Gelenke
% @param t Zeit in Sekunden
% @param T Sequenzdauer in Sekunden
% @param c1 
% @param c2
% @param k Kurvenschwimmen, Ausschlag im ersten Gelenk
%
% @return Enthält analog zum Rückgabewert von fit_pose.m n+1 Winkel, welche eine Schwanzpose beschreiben. Der erste ist Null, und dient der "Aufhängung"
%%
function [ alpha_v ] = get_servo_angles( n, t, T, c1, c2, k )

% Octave-Eigenschaft zur schnellen Tabellenbrechnung ausnutzen
idx = 0:n;

alpha_v = c1*idx.*sin(c2*idx-(t/T)*2*pi);
% Kurvenausschlag addieren:
alpha_v(2) = alpha_v(2)+k;
