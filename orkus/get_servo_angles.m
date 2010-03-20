function [ alpha_v ] = get_servo_angles( servo_count, t, coeffs )

a = coeffs(1);
b = coeffs(2);
k = coeffs(3);%kurvenschwimmen

servoIdx = 1:servo_count;

f1 = a*servoIdx.*sin(servoIdx*b-t*2*pi);
f1(1) = f1(1)+k;

alpha_v = [0 f1];
%kurve addieren:
