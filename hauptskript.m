%%
%
%
%
%
%
%%
function [] = hauptscript()

% Parameter laden
params;
% Benötigte Parameter in den lokalen Namensraum hohlen
n = param_n;
L = param_L;
alpha_max = param_alpha_max;
T = param_T;
f = param_f;
u = param_u;
% Das erste Skript aufrufen
[xJ_M yJ_M alpha_M] = fit_sequenz(f, u, T, n, L, alpha_max );

[c1 c2] = fit_emulation_coeffs( alpha_M );
coeffs_v = [c1 c2 0 T]

%coeffs_v = param_coeffs;
coeffs_M = coeffs_v*ones(1,T);

emulate_sequenz( coeffs_M, n, L, T, alpha_max )
