f(1) = 1
f(2) = 1
for i = 3 : 30
f(i) = f(i-1) + f(i-2)
% dolniq red e samo za golden seq!
g = f(i)/f(i-1)
end
