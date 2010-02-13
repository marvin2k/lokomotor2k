%%
% @brief Berechnet aus gegebenen Parametern eine Matrix von Servowinkeln. Beschreiben den zeitlichen Verlauf einer Bewegungssequenz
%
% @param f
% @param u
% @param n
% @param L
% @param alpha_max
%
% @return xJ_M
% @return yJ_M
% @return alpha_M
%
%%
function [xJ_M, yJ_M, alpha_M]=fit_sequenz( f, u, n, L, alpha_max )


% nur wenn sich der Schwanz komplett lang macht, hat er die maximale Länge
x=[0:L*n];
%wieviele einzelbilder in der Sequenz?
T=50;

% Matrizen vorbereiten
xJ_M = zeros(T,n+1);
yJ_M = zeros(T,n+1);
alpha_M = zeros(T,n+1);

for t=1:T

	pose = calc_pose( x, t, T, f, u );

	% Jeweils einen Ergebnisssatz in Rückgabe-Matrix abspeichern
	[xJ_M(t,:), yJ_M(t,:) alpha_M(t,:)] = fit_pose( pose, n, L, alpha_max );

end

for t=1:T

	clf;
	hold on;
	plot(pose);
	xlabel('<- Kopf | Abstand vom Kopf | Schwanz ->');
	ylabel('Seitliche Auslenkung');
	legend('Berechnete Schwanzpose');
	line([xJ_M(t,1:end-1);xJ_M(t,2:end)],[yJ_M(t,1:end-1);yJ_M(t,2:end)],'Color','r');
	axis([0 max(x) -max(max(abs(yJ_M))) max(max(abs(yJ_M)))],'equal');
	draw_half_circles( xJ_M(t,1:end-1), yJ_M(t,1:end-1), ones(1,n)*L, ones(1,n)*alpha_max, alpha_M(t,1:end-1));

	titlename = sprintf('Berechnete SinusKurve mit approximierten Schwanzsegementen\nn=%f L=%f alpha_{max}=%f',n,L,alpha_max);
	title(titlename);

	filename = sprintf('fit_sequenz_%04i.png',t);
	print(filename,'-dpng');
end

	% Video erstellen
callname = sprintf('ffmpeg -r 12 -i fit_sequenz_%%04d.png -y -an -b 1200k animation_fit_sequenz.mp4');
system(callname);

	% Alte Dateien aufraeumen:
for t = 1:T
	callname = sprintf('rm -f fit_sequenz_%04i.png',t);
	system(callname);
end
