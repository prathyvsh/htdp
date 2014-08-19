#|
To prove that f(n) belongs to O(g),
we have to prove that f(n) <= c.g(n)

where,

f(n) = n^2 + n
g(n) = c.n^2

This means,

n^2 + n <= c.n^2

which gives 1 + 1/n <= c

This means that c should be greater than 1 + 1/n after bigEnough

We can see that for all values > 0 for n, we can see that 1 + 1/n never grows beyond 1.

This means that, c >= 2 and bigEnough = 1

Thus for all n >= 1, and c = 2
we have n^2 + n <= 2.n^2
|#
