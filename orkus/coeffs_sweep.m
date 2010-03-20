function []=coeffs_sweep()

for a = -0.4:0.4:0.4
	for b = -0.4:0.4:0.4
		sequenz( [a b] );
	end
end
