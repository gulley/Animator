%% Smoke Test

h = animator;
assert(isequal(h.Animator.Name,"MATLAB Animator"))

%%

[sweepVar, startVal, sweepRange] = splitCode("x = 12;  %  1..20");
% assert(isequal(sweepVar,"x"))
% assert(isequal(startVal,12))
% assert(isequal(sweepRange,[1 20]))

%%

[sweepVar, startVal, sweepRange] = splitCode("result = 17;");
assert(isequal(sweepVar,"result"))
assert(isequal(startVal,17))
assert(isequal(sweepRange,[]))

%%

[sweepVar, startVal, sweepRange] = splitCode("result = -20.17;");
assert(isequal(sweepVar,"result"))
assert(isequal(startVal,-20.17))
assert(isequal(sweepRange,[]))

%%

[sweepVar, startVal, sweepRange] = splitCode("plot(1:10)");
assert(isequal(sweepVar,""))
assert(isequal(startVal,[]))
assert(isequal(sweepRange,[]))

