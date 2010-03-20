%%
% @brief Zeichnen eines Kreisabschnittes zum Anzeigen der maximaldrehwinkel
%
% Plottet zum Beispiel die maximalen Öffnungswinkel aller Gelenke einer Gelenkkette auf einmal.
% Ermöglicht auch flexible Öffnungswinkel und Gelenklängen...
%
% @param xM_v X-Koordinaten der Mittelpunkte
% @param yM_v Y-Koordinaten der Mittelpunkte
% @param r_v Radien der Kreise
% @param phi_var_v Halbe Öffnungswinkel der Kreisabschnitte
% @param phi_null_v Öffnungsrichtungen der Kreisabschnitte
%
% @return none
%
%%
function [ ] = draw_half_circles( xM_v, yM_v, r_v, phi_var_v, phi_null_v )

for i=1:length(r_v)
    phi=phi_null_v(i)-phi_var_v(i):0.001:phi_null_v(i)+phi_var_v(i);

    %polar:
    y_p = yM_v(i) + r_v(i)*sin(phi);
    x_p = xM_v(i) + r_v(i)*cos(phi);

    hold on;
    plot(x_p,y_p,'r')
    hold off;
end
