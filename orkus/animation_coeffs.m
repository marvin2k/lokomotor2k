%%
% Animation des Fischwanzes mit verschiednen Parametern
%%
function [coeffs] = animation_coeffs()

c1=[zeros(1,100) 1/100*[1:100]*0.07 ones(1,1000)*0.07 1/100*[100:-1:80]*0.07 ones(1,100)*0.056 1/100*[80:180]*0.07 ones(1,200)*0.07*1.8 1/100*[180:-2:1]*0.07 zeros(1,38)];
c2=[zeros(1,150) 1/100*[1:100]*1.2 ones(1,200)*1.2 1/100*[100:-1:50]*1.2 ones(1,169)*0.6 1/100*[50:80]*1.2 ones(1,900) 1/100*[100:-1:1]*1 zeros(1,49)];
k=[zeros(1,800) 1/50*[1:50]*0.15 ones(1,150)*0.15 1/50*[50:-1:1]*0.15 zeros(1,700)];
f_schwanz = [ones(1,1100)*40 ones(1,650)*20];

%size(c1)
%subplot(4,1,1);plot(c1)
%size(c2)
%subplot(4,1,2);plot(c2)
%size(k)
%subplot(4,1,3);plot(k)
%size(f_schwanz)
%subplot(4,1,4);plot(f_schwanz)

coeffs = [c1;c2;k;f_schwanz]';

seq_len = length(coeffs);

clf;
plot([1:seq_len],coeffs(:,1)/max(abs(coeffs(:,1))),[1:seq_len],coeffs(:,2)/max(abs(coeffs(:,2))),[1:seq_len],coeffs(:,3)/max(abs(coeffs(:,3))),[1:seq_len],coeffs(:,4)/max(abs(coeffs(:,4))));

frame=225;line([frame frame], [-0.2 1.2],'Color','k');

legend('c_1','c_2','k','f');
axis([1 seq_len -0.2 1.2]);

