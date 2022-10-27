%% Smoke Test

h = animator;

%%

[var,val,rng] = splitCode("x = 12;  %  1..20");

%%

[var,val,rng] = splitCode("result = 17;");

%%

[var,val,rng] = splitCode("result = -20.17;");

%%

[var,val,rng] = splitCode("plot(1:10)");

