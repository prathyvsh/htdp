;; TERMINATION ARGUMENT

The algorithm computes the next iteration by taking the remainder
of the large number by the smaller number. Let x be the larger
number and y the smaller one. On performing x % y, we acquire
a value that is in the range 0 - (y-1). Since this value is
always less than y, we can infer that it is converging towards 0
and would hence terminate. In the worst case, it would reduce to 1,
which is the lowest GCD two numbers can have.
