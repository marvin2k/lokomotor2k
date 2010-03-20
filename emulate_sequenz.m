%%
% @brief Erstellung einer Sequenz beliebiger Länge mit gegebener Parametermatrix welche zuvor berechnet werden sollte.
%
% Plottet jeweiligen Schwanzverlauf zusammen mit dem zeitlichen Verlauf der Parameter, jeweils normiert auf 1, mit Zeitbalken
%
%
% @param coeffs_M Enthält c1 c2 k und delta_t, jeweils eine Zeile für ein einzelnes Bild der gesamten Sequenz. DAmit kodiert diese Matrix auch die Länge der Animationssequenz (die Anzahl der zu erzeugenden Bilder)
% @param n Anzahl der Gelenke des Fischschwanzes
% @param L Länge der Einzelnen Gelenkabschnitte
% @param alpha_max Maximaler Biegeradius (TODO: Auswerten, wird zur Zeit nur zur Anzeige verwendet)
%
% @return Das übliche... Koordinaten und Winkel über die Zeit
%%
function [xJ_M yJ_M alpha_M]=emulate_sequenz( coeffs_M, n, L, alpha_max )
% Frames per Second, für die zu erstellende Animation
fps = 24;

% Anzahl der Einzelbilder, entsprechend der Anzahl der Koeffizienten
animation_length = length(coeffs_M);

% Matrizen vorbereiten
xJ_M = zeros(animation_length,n+1);
yJ_M = zeros(animation_length,n+1);
alpha_M = zeros(animation_length,n+1);

t_seq = 0;
for frame = 1:animation_length

	% Vorbereitungen:

	% Aktuelle Parameter feststellen (Eigentlich nur zum plotten nötig)
	c1 = coeffs_M(frame,1);%amplitude
	c2 = coeffs_M(frame,2);%welligkeit
	k = coeffs_M(frame,3);%kurve
	delta_t = coeffs_M(frame,4);%schlagfrequenz

	% t weiterlaufen lassen, darf auch über 1 hinausgehen, wird später mit 2pi normiert und fällt dann in die Periodizität von sin weg
	t_seq = t_seq + delta_t

	% Kernstück: Berechnung der Stellung
	[xJ_M(frame,:), yJ_M(frame,:) alpha_M(frame,:)] = emulate_pose( coeffs_M(frame,:), n, L, t_seq );

	clf;
	hold on;
	subplot(2,1,1)

	% Plotten der Gelenkkette
	hold on;
	xlabel('<- Kopf | Abstand vom Kopf | Schwanz ->');
	ylabel('Seitliche Auslenkung');
	line([xJ_M(frame,1:end-1);xJ_M(frame,2:end)],[yJ_M(frame,1:end-1);yJ_M(frame,2:end)],'Color','r');
	axis([0 (n+1)*L -3*L 3*L],'equal');
	draw_half_circles( xJ_M(frame,1:end-1), yJ_M(frame,1:end-1), ones(1,n)*L, ones(1,n)*alpha_max, alpha_M(frame,1:end-1));
	titlename = sprintf('Emulierte Schwanzsegemente\nc1=%f c2=%f k=%f delta_t=%f',c1,c2,k,delta_t);
	title(titlename);

	subplot(2,1,2)

	% Plotten der Zeitachse des Parametersatzes, mit Zeitmarke
	t_axis = linspace(0,animation_length/fps,animation_length);
%	plot(t_axis,coeffs_M(:,1)/max(abs(coeffs_M(:,1))),t_axis,coeffs_M(:,2)/max(abs(coeffs_M(:,2))),t_axis,coeffs_M(:,3)/max(abs(coeffs_M(:,3))),t_axis,coeffs_M(:,4)/max(abs(coeffs_M(:,4))));
	% zeichnen der "Zeitbarke"
	line([t_axis(frame) t_axis(frame)], [-0.2 1.2],'Color','k');
%	legend('c_1','c_2','k','delta_t');
	ylabel('c/c_{max}')
	xlabel('t in Sekunden');
	axis([1 max(t_axis) -0.2 1.2]);

	titlename = sprintf('c_1=%f c_2=%f k=%f delta_t=%f\nt_seq=%f',c1,c2,k,delta_t,t_seq);
	title(titlename);

	filename = sprintf('plots/anim_%04i.png',frame);
	print(filename,'-dpng');
end

%identifier = sprintf('c1-%1.4f_c2-%1.4f',c1,c2);
%callname = sprintf('ffmpeg -r 24 -i ./plots/anim_%%04d.png -y -an -b 1200k ./animations/animation_%s.mp4',identifier);
%system(callname);

% Alte Dateien aufraeumen:
%for frame = 1:seq_len
%	callname = sprintf('rm -f plots/anim_%04i.png',frame);
%	system(callname);
%end
