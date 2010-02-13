%%
% @brief Diese Datei wird von allen Skripten geladen und enthält die wichtigen Parameter zu laden
%
% Durch Prefix "param_" kann beim Laden vom lokalen Namensraum des Skriptes sauber getrennt werden.
%%

% Anzahl Gelenke
param_n = 5;
% Länge der Gelenksegmente in mm
param_L = 1000;
% Maximaler Gelenkwinkel
param_alpha_max = 29/360*2*pi;
% Wieviele Einzelschritte für eine Sequenz
param_T = 50;

% Eigenschaften der zugrundeliegenden x*sin-Schwingung
param_f = 0.018;
param_u = 0.1;

% Bereits ermittelte Beispielwerte für c1 und c2, Kurvenschwimmen und Sequenzdauer
param_c1 = 1;
param_c2 = 1;
param_k = 0;
%param_T = 50;%gibts schon, oben
param_coeffs = [param_c1 param_c2 param_k param_T];
