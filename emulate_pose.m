%%
% @brief Berechnung eines Vektors von Servowinkeln, welche eine Schwanzpose beschreiben. Kurvenschwimmen bereits eingebaut
%
% @param coeffs_v Koeefizientenvektor mit c1 c2 k und T
% @param n Anzahl der Gelenke
% @param L Länge der Gelenkstücke
% @param t_seq Ein Zeitpunkt. Jede Sequenz liegt in dem Bereich von 0 bis 1"t". delta_t läuft von 0 bis unendlich wird aber durch die multiplikation mit 2pi im sin rausgenommen. Die Änderungen von delta_t ist dann die "Geschwindigkeit" mit der die Seqeunz ausgeführt wird. In der späteren Animation wird dann jedes Bild gleich lange eingeblendet
% @param alpha_max Wird nur zur korrekten Anzeige verwendet, falls hier ein Graph während des debugging geplottet werden soll
%
% @return xJ_v Vektor von X-Koordinaten der Joints einer Gelenkkette der Länge n+1, beginnend mit [0,0] 
% @return yJ_v Vektor von Y-Koordinaten der Joints einer Gelenkkette der Lange n+1, beginnend mit [0,0] 
% @return Enthält analog zum Rückgabewert von fit_pose.m n+1 Winkel, welche eine Schwanzpose beschreiben. Der erste ist Null, und dient der "Aufhängung"
%%
function [xJ_v yJ_v alpha_v] = emulate_pose( coeffs_v, n, L, t_seq, alpha_max )
    
    c1 = coeffs_v(1);
    c2 = coeffs_v(2);
    k = coeffs_v(3);

    xJ_v = zeros(1,n+1);
    yJ_v = zeros(1,n+1);
    alpha_v = zeros(1,n+1);

    % Octave-Eigenschaft zur schnellen Tabellenbrechnung ausnutzen
    idx = 0:n;
    % In einem Rutsch alle Winkel berechnen
    alpha_v = c1*idx.*sin(c2*idx-t_seq*2*pi);
    % Kurvenausschlag addieren:
    % TODO: muss heir nicht der erste winkel adressiert werden?
    alpha_v(2) = alpha_v(2)+k;

    % Nun noch die Endpunkte der Gelenkkette mittels der berechneten Winkel berechnen
    % das ist eigentlich nur kosmetischer natur, der echte roboter braucht das natürlich nicht wissen
    for idx=2:n+1
        xJ_v(idx) = L*cos( alpha_v(idx) ) + xJ_v(idx-1);
        yJ_v(idx) = L*sin( alpha_v(idx) ) + yJ_v(idx-1);
    end

%    clf;
%    hold on;
%    xlabel('<- Kopf | Abstand vom Kopf | Schwanz ->');
%    ylabel('Seitliche Auslenkung');
%    line([xJ_v(1:end-1);xJ_v(2:end)],[yJ_v(1:end-1);yJ_v(2:end)],'Color','r');
%    axis([0 (n+1)*L -3*L 3*L],'equal');
%    draw_half_circles( xJ_v(1:end-1), yJ_v(1:end-1), ones(1,n)*L, ones(1,n)*alpha_max, alpha_v(1:end-1));
%    titlename = sprintf('Emulierte Schwanzsegemente\nc1=%f c2=%f k=%f delta_t=%f',c1,c2,k,delta_t);
%    title(titlename);

%    filename = sprintf('plots/emulate_pose.png');
%    print(filename,'-dpng');
