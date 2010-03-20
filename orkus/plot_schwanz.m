function  []=plot_schwanz( len_bone, alpha_v )
alpha_max = 2*29/360*(2*pi);

% es gibt zwar genau so viele endpunkt wie fixpunkte, und die fixpunkte liegen auf der linken seite eines gelenkteiles, die endpunkte auf der rechten. allerdings ist es einfacher, ein virtuelles gelenk mit endpunkt in 0/0 zu nehmen um die forschleife besser laufen zu lassen
% alpha_v hat als erstes Element eine Null und n+1 Elemente

xF = zeros(1,length(alpha_v));
yF = zeros(1,length(alpha_v));

xE = zeros(1,length(alpha_v));
yE = zeros(1,length(alpha_v));

alpha_alt = 0;

for i = 2:length(alpha_v)

	xF(i) = xE(i-1);
	yF(i) = yE(i-1);
    
%	if ( alpha_v(i-1) > alpha_max )
%		alpha_v(i-1) = alpha_max;
%	else if ( alpha_v(i-1) < -alpha_max )
%		alpha_v(i-1) = -alpha_max;
%	end;

    xE(i) = xF(i) + len_bone*cos(alpha_v(i)+alpha_alt);
    yE(i) = yF(i) + len_bone*sin(alpha_v(i)+alpha_alt);

	myCircPart( xF(i), yF(i), len_bone, alpha_max/2, alpha_v(i-1)+alpha_alt );

	alpha_alt = alpha_alt + alpha_v(i);

	line([xF(i) xE(i)], [yF(i) yE(i)], 'Color','b');

end;


%fischkopf zeichen
rectangle('Curvature',[0.4],'Position',[-230 -50 230 100],'EdgeColor','b');
%vorder flossen zeichnen (hochkant stehende gleichschenklige dreiecke)
h = 80;w = 10;%höhe des dreieckes und breite/2
x1 = -40; y1 =  40;x2 = x1-w; y2 = y1+h;x3 = x1+w;y3 = y1+h;
line([x1 x2],[y1 y2])
line([x2 x3],[y2 y3])
line([x3 x1],[y3 y1])

x1 = -40; y1 = -40;x2 = x1-w; y2 = y1-h;x3 = x1+w;y3 = y1-h;
line([x1 x2],[y1 y2])
line([x2 x3],[y2 y3])
line([x3 x1],[y3 y1])

%schwanzflosse zeichen (waagerecht liegendes gleichschenkliges dreieck, rotiert um alpha_alt=(alpha_v(end)+alpha_alt(-1))
l = 0.8*len_bone;phi = pi/20;%laenge der langen dreicksseite und und der halbe öffnungswinkel
x1 = xE(end); y1 = yE(end);
x2 = x1 + l*cos(+phi+alpha_alt);
y2 = y1 + l*sin(+phi+alpha_alt);
x3 = x1 + l*cos(-phi+alpha_alt);
y3 = y1 + l*sin(-phi+alpha_alt);
line([x1 x2],[y1 y2])
line([x2 x3],[y2 y3])
line([x3 x1],[y3 y1])



grid on;
axis([-415.7 852.1 -200 200]);%handgewählte grenzen um gleichskalierte achsen zu erzeugen

xlabel('Abstand Kopfende [mm]');
ylabel('Auslenkung [mm]');
