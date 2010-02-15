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
number_of_frames = param_number_of_frames;
f = param_f;
u = param_u;
% Das erste Skript aufrufen
[xJ_M yJ_M alpha_M] = fit_sequenz(f, u, number_of_frames, n, L, alpha_max );

[c1 c2] = fit_emulation_coeffs( alpha_M );
animation_length = param_animation_length;
delta_t = param_delta_t;
% Parameter aus Datei laden: %c1 = param_c1; %c2 = param_c2;
%k fehlt noch
coeffs_v = [c1 c2 0 delta_t];

% Paramter übernehmen (Zusammengebaute Matrix Transponieren!)
coeffs_M = [c1*ones(1,animation_length); c2*ones(1,animation_length); 0*ones(1,animation_length); delta_t*ones(1,animation_length)]';

[xJ_M2 yJ_M2 alpha_M2] = emulate_sequenz( coeffs_M, n, L, animation_length, alpha_max );
