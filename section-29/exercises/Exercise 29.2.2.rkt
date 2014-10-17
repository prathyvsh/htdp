#|

f(n) = 2^n
g(n) = 1000*n


For g to belong to O(f)
we have to prove that
g(n) <= c.f(n)

that is,

1000*n <= c. 2^n

c >= 1000*n/2^n

We can see that for all values of n >= 14, c should only be >= 1.

Hence we have for bigEnough = 14 and c = 1, g belongs to O(2^n)

If the input is guaranteed to be between 3 and 12, we have
f(n) performing better since the bigEnough threshold is 14.

|#
