%%
% @brief Berechnet zu einer einzelnen Schwanzpose einen Vektor von n Servowinkeln
%
% @param pose
% @param n
% @param L
% @param alpha_max
% @param
%
% Rückgabewerte jeweils passend zur gegebenen Pose
%
% @return xJ_v Vektor von X-Koordinaten der Joints einer Gelenkkette der Länge n+1, beginnend mit [0,0] 
% @return yJ_v Vektor von Y-Koordinaten der Joints einer Gelenkkette der Lange n+1, beginnend mit [0,0] 
% @return alpha_v Vektor von Servowinkeln in rad einer Gelenkkette der Länge n+1, beginnend mit 0
%
%%
function [xJ_v yJ_v alpha_v]=fit_pose( pose, n, L, alpha_max )

	% xJ_v(1) ist der Startpunkt der Gelenkkette, und Null. xJ_v(2) ist der Endpunkt
	% des ersten Gelenks und gleichzeitig der Startpunkt des zweiten. Usw...
	xJ_v = zeros(1,n+1);
	yJ_v = zeros(1,n+1);
	alpha_v = zeros(1,n+1);

	%bei 2 beginnend, der erste Index ist der "Fixpunkt" und dient der Aufhängung
	for idx=2:n+1
		%TODO fitJoint umbauen und die beachtung des letzten winkel und des maximalen winkels hier hin verlagern
        alpha_v(idx) = fitJoint( alpha_v(idx-1), alpha_max, xJ_v(idx-1), yJ_v(idx-1), pose );
        xJ_v(idx) = L*cos( alpha_v(idx) ) + xJ_v(idx-1);
        yJ_v(idx) = L*sin( alpha_v(idx) ) + yJ_v(idx-1);
	end

	%clf;
	%hold on;
	%plot(pose);
	%xlabel('<- Kopf | Abstand vom Kopf | Schwanz ->');
	%ylabel('Seitliche Auslenkung');
	%legend('Berechnete Schwanz Pose');
	%line([xJ_v(1:end-1);xJ_v(2:end)],[yJ_v(1:end-1);yJ_v(2:end)],'Color','r');
	%titlename = sprintf('Berechnete SinusKurve mit approximierten Schwanzsegementen\nn=%f L=%f alpha_maxf=%f',n,L,alpha_max);
	%title(titlename);

	%filename = sprintf('fit_pose.png');
	%print(filename,'-dpng');
end
