%%
% @brief Minimierungsfunktion um Gelenkwinkel zu schätzen
% 
% TODO: Holzklassefunktion, überarbeiten...
%
%%
function [alpha] = fitJoint( alpha_last, alpha_max, xF, yF, sineCurve );

%seltsamer startwert nötig, da der such algorithmus irgendwie positive winkel zu bevorzugen scheint. wenn bei null begonnen wird zu suchen werden keine gelenkwiinkel unter ungefähr -0.5rad beachtet. deswegen ganz hinten anfangen
alpha = fminsearch(@funfun,[-0.5],[],[],alpha_last, alpha_max, xF, yF, sineCurve);

end



function [out]=funfun(alpha, alpha_last, alpha_max, xF, yF, sineCurve)
badnumber=bitmax;

xE_v(1)=0;
yE_v(1)=0;
L=60;
x=[0:length(sineCurve)];
y_fun=zeros(size(x));
out=0;

    if (alpha < (alpha_last-alpha_max)) out=badnumber;return;end
    if (alpha > (alpha_last+alpha_max)) out=badnumber;return;end

    xE = L*cos( alpha ) + xF;
    yE = L*sin( alpha ) + yF;

    if ( (xE-xF)<1 ) out=badnumber;return;end%nötig? ja!

    xF = floor(xF)+1;
    yF = floor(yF)+1;
    xE = floor(xE)+1;
    yE = floor(yE)+1;

    n =  yF-(yF-yE)/(xF-xE)*xF;
    m = (yE-yF)/(xE-xF);

    y_fun(xF:xE) = m*x(xF:xE) + n;


diff = y_fun(xF:xE) - sineCurve(xF:xE);

sq_diff = diff.^2;
if (out ~= badnumber)
    out = sum(sq_diff);
end
end
