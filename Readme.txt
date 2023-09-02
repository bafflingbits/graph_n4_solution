
== Proof of Krenn's conjecture for n=4

files:
  g43.s       # Singular script file for n=4 c=3 graph problem
  out_g43.txt # saved output from running g43.s

This proves that the only solutions to n=4 c=3 have the following properties:
- the multi-color weights = 0
- the mono-chromatic weights are non-zero for only a single perfect matching
    in each color
- the three mono-chromatic pefect matchings have a disjoint set of edges

In other words, despite allowing complex weights, the solutions for n=4 c=3
are equivalent to the simple solutions using non-negative real values weights.

Now assume by contradiction that there exists a solution to n=4 c>3.
The constraints are such that any subset of three colors in that
weight set must satisfy the n=4 c=3 constraints.
Therefore, for any 3 colors, the mono-chromatic weights should only be
non-zero for a single perfect matching and the perfect matchings should be
disjoint between the colors.
However with n=4, at most there are three disjoint perfect matchings, and
so by the pigeonhole principle not every set of three colors in a hypothetical
c>3 solution can have a different matching.
And so by contradiction, no solution to n=4 c>3 can exist.


== Alternative approach to characterize n=4 c=3 solutions

files:
  fast_g43.s
  out_fast_g43.txt

Sometimes it is quicker to help out the computer algebra system
by rephrasing the question a bit. The following approach completes in
10 seconds, instead of ~ 10 minutes of the previous approach.

This tries to finds solutions to n=4 c=3 with a non-zero multi-color edge
weight. Without loss of generality, edge-weight w0101 is chosen to be
non-zero. If there is a solution with it non-zero, we can always obtain
a solution with it equal to 1 by:
  - scaling all w01xx weights by 1/w0101
  - scaling all w23xx weights by w0101
So without loss of generality, let w0101 = 1.

This leads to a contradiction.
The ideal is {1}, so a solution would have to satisfy the
constraint 1 == 0.
So there are no n=4 c=3 solutions with a non-zero multi-color edge weight.


== To try out the calculations yourself

# download and build Singular computer algebra system
./build_singular.sh

# use a python program to generate the constraints
# and output in a form usable as a Singular script
./gen_constraints.py 4 3 > g43.s

# run the Singular script
./run-Singular-script.sh g43.s


== Scripts that take too much memory for me to run

# try to get Singular to carry intermediate information during calculation
# so that it can show the explicit construction of the Groebner basis
# in terms of the original constraint polynomials
g43_liftstd.s

# similar calculation, but focussing on constructing just one polynomial
# from the original constraint polynomials
g43_lift.s

