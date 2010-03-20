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
% Wieviele Einzelschritte innerhalb einer Bewegungsseqeunz für die Approximation der Paramter
param_number_of_frames = 50;

% Eigenschaften der zugrundeliegenden x*sin-Schwingung
param_f = 0.0009;
param_u = 0.1;

% Bereits ermittelte Beispielwerte für c1 und c2, Kurvenschwimmen und Sequenzdauer
param_c1 = 1;
param_c2 = 1;
param_k = 0.00001;%damits beim normierne keine division durch null gibt...
param_delta_t = 0.1;
param_animation_length = 50;%gibts schon, oben
