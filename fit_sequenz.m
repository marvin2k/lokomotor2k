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

% nur wenn sich der Schwanz komplett lang macht, hat er die maximale Länge
x=[0:L*n];
%wieviele einzelbilder in der Sequenz?

% Matrizen vorbereiten
xJ_M = zeros(number_of_frames,n+1);
yJ_M = zeros(number_of_frames,n+1);
alpha_M = zeros(number_of_frames,n+1);

for frame=1:number_of_frames

	pose = calc_pose( x, frame, number_of_frames, f, u );

	% Jeweils einen Ergebnisssatz in Rückgabe-Matrix abspeichern
	[xJ_M(frame,:), yJ_M(frame,:) alpha_M(frame,:)] = fit_pose( pose, n, L, alpha_max );

end

for frame=1:number_of_frames

	clf;
	hold on;
	plot(pose);
	xlabel('<- Kopf | Abstand vom Kopf | Schwanz ->');
	ylabel('Seitliche Auslenkung');
	legend('Berechnete Schwanzpose');
	line([xJ_M(frame,1:end-1);xJ_M(frame,2:end)],[yJ_M(frame,1:end-1);yJ_M(frame,2:end)],'Color','r');
	axis([0 max(x) -max(max(abs(yJ_M))) max(max(abs(yJ_M)))],'equal');
	draw_half_circles( xJ_M(frame,1:end-1), yJ_M(frame,1:end-1), ones(1,n)*L, ones(1,n)*alpha_max, alpha_M(frame,1:end-1));

	titlename = sprintf('Berechnete SinusKurve mit approximierten Schwanzsegementen\nn=%f L=%f alpha_{max}=%f',n,L,alpha_max);
	title(titlename);

	filename = sprintf('fit_sequenz_%04i.png',frame);
	print(filename,'-dpng');
end

	% Video erstellen
callname = sprintf('ffmpeg -r 12 -i fit_sequenz_%%04d.png -y -an -b 1200k animation_fit_sequenz.mp4');
system(callname);

	% Alte Dateien aufraeumen:
for frame = 1:number_of_frames
	callname = sprintf('rm -f fit_sequenz_%04i.png',frame);
	system(callname);
end
