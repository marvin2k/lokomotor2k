%%
% @brief Erstellung einer Sequenz beliebiger Länge mit gegebener Parametermatrix
%
% @param coeffs_M Enthält c1 c2 k und T, jeweils eine Zeile für ein einzelnes Bild der gesamten Sequenz. Somit kodiert diese Matrix auch die Länge der Animationssequenz in Bildern
% @param n Anzahl der Gelenke
% @param L Länge der Einzelnen Gelenkabschnitte
% @param alpha_max Maximaler Biegeradiu (TODO: Auswerten, wird zur Zeit nur zur Anzeige verwendet)
%
% @return Das übliche... Koordinaten und Winkel
%%
function [xJ_M yJ_M alpha_M]=emulate_sequenz( coeffs_M, n, L, alpha_max )

% Anzahl der Einzelbilder, entsprechend der Anzahl der Koeffizienten
animation_length = length(coeffs_M);

for frame = 1:seq_len
	clf;
	% Aktuelle Parameter feststellen (Eigentlich nur zum plotten nötig)
	c1 = coeffs_M(frame,1);%amplitude
	c2 = coeffs_M(frame,2);%welligkeit
	k = coeffs_M(frame,3);%kurve
	T = coeffs_M(frame,4);%schlagfrequenz

	t=t+1/T;

	alpha_v = get_servo_angles( 5, t, coeffs_M(frame,:) );
	alpha_M(frame,:) = alpha_v;
	% Plot für Animation: Ein Schwanz immer der gleichen Farbe, der jedesmal gelöscht wird
subplot(2,1,1)
	plot_schwanz( len_bone, alpha_v );
subplot(2,1,2)

	% alle coeffizienten über die zeit plotten, normiert auf das jeweilige maximum, mit Zeitmarke
	t_axis = linspace(0,seq_len/24,seq_len);
	plot(t_axis,coeffs(:,1)/max(abs(coeffs(:,1))),t_axis,coeffs(:,2)/max(abs(coeffs(:,2))),t_axis,coeffs(:,3)/max(abs(coeffs(:,3))),t_axis,coeffs(:,4)/max(abs(coeffs(:,4))));
	% "zeitbarke"
	line([t_axis(frame) t_axis(frame)], [-0.2 1.2],'Color','k');
	legend('c_1','c_2','k','f');
	ylabel('c/c_{max}')
	xlabel('t in Sekunden');
	axis([1 max(t_axis) -0.2 1.2]);

	% Plot um jede Schwanzform in einem Bild anzuzeigen. Schwanzfarbe ändert sich und wird nicht gelöscht -> "Schatten" Effekt
	% Keine Roten Gelenkwinkelbereichsanzeigekreise. Das fertige Bild aus dem Plots-Ordner rauskopieren
	%plot_schwanz2( len_bone, alpha_v, t );
	% Plot der reinen Sinus-Kurve, mehrere Kurven in einem Bild
	%u=0.3;f=0.009;plot_schwanz3( t, u, f );

	titlename = sprintf('c_1=%1.1f c_2=%1.1f\nt=%1.2fT f=%1.1f k=%1.2f',c1,c2,mod(t,1),f_schwanz,k);
	title(titlename);

	filename = sprintf('./plots/anim_%04i.png',frame);
	print(filename,'-dpng');
end

hold off;

identifier = sprintf('c1-%1.4f_c2-%1.4f',c1,c2);
callname = sprintf('ffmpeg -r 24 -i ./plots/anim_%%04d.png -y -an -b 1200k ./animations/animation_%s.mp4',identifier);
system(callname);

% Alte Dateien aufraeumen:
for frame = 1:seq_len
	callname = sprintf('rm -f plots/anim_%04i.png',frame);
	system(callname);
end
