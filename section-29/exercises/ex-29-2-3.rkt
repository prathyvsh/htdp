#|
f(n) = n log n
g(n) = n^2

For f belonging to O(g),
we need to prove

f(n) <= c.g(n)

n log(n) <= c.n^2
which means,

log(n) <= c.n

For c = 1 and bigEnough = 1,
we have log n <= n,

thus f(n) belongs to O(g).
|#

