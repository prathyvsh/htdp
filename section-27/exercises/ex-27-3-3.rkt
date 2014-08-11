#|

If the interval between left and right is r - l = S1 (r > l), in the recursive call,
the interval gets reduced to
r - (r + l)/2 = r - r/2 - l/2 = r/2 - l/2 = (r - l)/2 = S1/2.

That is the interval gets halved. The process repeats,
hence it can be understood that the value becomes smaller and smaller.

Hence if tolerance is a value > 0, the find root will reach this number
as it is converging to 0 on each halving.

|#
