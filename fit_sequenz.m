%%
% @brief Berechnet aus gegebenen Parametern eine Matrix von Servowinkeln. Beschreiben den zeitlichen Verlauf einer Bewegungssequenz
%
% @param f Frequenz der zugrundeliegenden x*Sinus-Schwingung
% @param u Amplitude der zugrundeliegenden x*Sinus-Schwingung
% @param number_of_frames Anzahl der Einzelschritte für eine komplette Sequenz
% @param n Gelenkanzahl
% @param L Gelenklnge in mm
% @param alpha_max Maximaler Öffnungswinkel in rad
%
% @return xJ_M Matrix aller X-Koordinaten des Ursprungs und aller Gelenkenden. Jede Zeile eine Stellung
% @return yJ_M Matrix aller X-Koordinaten des Ursprungs und aller Gelenkenden. Jede Zeile eine Stellung
% @return alpha_M Matrix aller Gelenkwinkel des Ursprungs und aller Gelenke. Jede Zeile eine Stellung
%
%%
function [xJ_M, yJ_M, alpha_M]=fit_sequenz( f, u, number_of_frames, n, L, alpha_max )
fps=24;

% nur wenn sich der Schwanz komplett lang macht, hat er die maximale Länge
x=[0:L*n];
%wieviele einzelbilder in der Sequenz?

% Matrizen vorbereiten
xJ_M = zeros(number_of_frames,n+1);
yJ_M = zeros(number_of_frames,n+1);
alpha_M = zeros(number_of_frames,n+1);
pose = zeros(number_of_frames,length(x));

for frame = 1:number_of_frames

    pose(frame,:) = calc_pose( x, frame, number_of_frames, f, u );

    % Jeweils einen Ergebnisssatz in Rückgabe-Matrix abspeichern
    [xJ_M(frame,:), yJ_M(frame,:) alpha_M(frame,:)] = fit_pose( pose(frame,:), n, L, alpha_max );

end

    % Zeichnen
%for frame = 1:number_of_frames
%
%   clf;
%    hold on;
%    plot(pose(frame,:));
%    xlabel('<- Kopf | Abstand vom Kopf | Schwanz ->');
%    ylabel('Seitliche Auslenkung');
%    line([xJ_M(frame,1:end-1);xJ_M(frame,2:end)],[yJ_M(frame,1:end-1);yJ_M(frame,2:end)],'Color','r');
%    axis([0 n*L*1.1 -max(max(abs(yJ_M)))*1.5 max(max(abs(yJ_M)))*1.5],'equal');
%    % selbst gebaute Funktion zum anzeigen der physikalisch möglichen Drehwinkel eines Gelenks
%    draw_half_circles( xJ_M(frame,1:end-1), yJ_M(frame,1:end-1), ones(1,n)*L, ones(1,n)*alpha_max, alpha_M(frame,1:end-1));
%
%    legend('Berechnete Schwanzpose','Segmentgeraden des Roboterschwanzes');
%    titlename = sprintf('Berechnete SinusKurve mit approximierten Schwanzsegementen\nn=%i L=%i alpha_{max}=%f',n,L,alpha_max);
%    title(titlename);
%
%    filename = sprintf('plots/fit_sequenz_%04i.png',frame);
%    print(filename,'-dpng');
%end
%
%    % Video erstellen
%callname = sprintf('ffmpeg -r %i -i plots/fit_sequenz_%%04d.png -y -an -b 1200k animations/animation_fit_sequenz.mp4',fps);
%system(callname);
%
%    % Alte Dateien aufraeumen:
%for frame = 1:number_of_frames
%    callname = sprintf('rm -f plots/fit_sequenz_%04i.png',frame);
%    system(callname);
%end
