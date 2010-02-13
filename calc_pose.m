%%
% @brief Berechnet eine Schwanzpose mit fest einkodierter mathematischer Funktion für einen einzelnen Zeitpunkt
%
% @param x X-Achsenvektor, für welchen die Berechnung durchgeführt wird. Gewöhnlich ab Null aufsteigend
% @param t Simulations Zeit, kann fortschreitend sein. Wird dann mit T normiert
% @param T Dauer einer Periode der Bewegungssequenz
% @param f Frequenz der Sinusschwingung 
% @param u Amplitude, gibt an wie schnell die Sinus-Kurve an Energie gewinnt
%  
% @return y Y-Achsenvektor, welche den Kurvenausschlag bescheibt. Könnte zusammen mit x geplottet werden
%
%%
function [ y ] = calc_pose( x, t, T, f, u )

	y = (x*u).*(sin( x*f - 2*pi*(t/T) ));

end
