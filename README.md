
# Proof of Krenn's conjecture for n=4

The following demonstrates that a monochromatic graph with four nodes (n=4)
and four colors (c=4) does not exist, thus proving Krenn's conjecture for
the n=4 case. In fact, something slightly stronger can be proven:

> There is a unique set of edges for the four node, three color monochromatic
graph (up to node and color relabelling), which is just a coloring of `K_4` 
(the complete simple graph on four nodes).

This is a slightly stronger statement, as the non-existence of an n=4 c=4
monochromatic graph can be derived from this.


## Krenn's conjecture

The conjecture relates to the existence of "monochromatic" graphs with weighted
and colored edges. Details can be found here:
- https://mariokrenn.wordpress.com/graph-theory-question/

The following will assume familiarity with the conjecture and related
terminology.


## Polynomial constraints

The constraints on the edge weights for a graph to be monochromatic
can be written as a set of multilinear polynomials in the edge weights,
where a "solution" (the existence of a monochromatic graph) would
satisfy that every polynomial in the set evaluates to zero.

There is a constraint for each possible color labeling of the nodes.
So for a n node, c color monochromatic graph, there are `c^n` polynomial constraints.

To keep this as general as possible, all possible edges variables are included
and only after a solution is found, and an edge weight is constained to
zero in a particular solution, would we say that the edge is "not in"
the resulting graph.


### Naming convention

An edge can be specified by a node and color (n1,c1) for one end, (n2,c2) for
the other ends, and a weight.

The edge weight variables are named: `w{n1}{n2}{c1}{c2}`

Where n1,n2 are labels for the nodes connected by the edges,
and c1,c2 are are labels for the colors associated with the edge endpoints
(color c1 with n1, color c2 with node n2).

Since the edge weights are undirected in this problem, it is always taken that
`n1 < n2` in the edge weight name.

This means when considering an n node, c color monochromatic graph,
there are `c^2*n*(n-1)/2` edge weight variables.


# Calculations

All the calculations were done with the computer algebra system Singular.
- https://www.singular.uni-kl.de/

A python script `gen_constraints.py` was made to programmaticly generate
a Singular script listing the variables and constraints for a given number
of nodes and colors. Then minor additions to the script can be made
depending on the intended calculation.

The Singular scripts names look like `g{n}{c}_*.s`, where n is the number of
nodes and c is the number of colors for the underlying graph in that
calculation.

## Groebner basis calculations

A common method for solving a system of multi-variate complex valued polynomial
constraints is to first calculate a Groebner basis of the constraint polynomials.

This is an interesting subject, but the only details we need to know here is that
the resulting Groebner basis is another set of polynomials which describe the same
set of constraints. These are "simpler" in a specific sense that is not necessary
to get into here, except one specific case: if there is no solution in the
complex numbers, it is guaranteed that the Groebner basis will collapse to a
set of just one polynomial: {1}. As the resulting polynomial set describing the
same constraints, this means any solution would have to satisfy 1 = 0. This is
how "no solution" is represented mathematically here.

## Lifting calculations

Let `F` be the set of polynomials we are initially using to define our constraint
system, where the overall constraint is that: for all `f_i` in `F`, `f_i =0`.

This means that for *any* polynomial g that we can write in terms of our edge
weight varibles, for any `f_i` in `F`, `g f_i = 0` is also must hold for a solution.

That sounds very trivial, but now let's consider a list of polynomials `G`,
that provides a polynomial to pair with each polynomial in `F`.  Now we can write
a sum

`X = sum_i f_i g_i`, where `f_i` are polynomial in `F`, and `g_i` are polynomial in `G`.

Again, fairly trivially, this means the sum, `X`, must be zero for any solution.
I'll refer to this as a "derived constraint".

Now a "lifting" calculation essentially asks this in reverse. Given some polynomial
`X`, can we find polynomial valued "coefficients", such that as unevaluated polynomials,
we can write `X` in terms of our constraint polynomials `f_i` like so:

`X = sum_i f_i g_i`

in which case we have proven ("derived") that `X` is also a constraint on our solutions.

(In fact this relates to the sense in which a Groebner basis is a "simpler" description
of the polynomial constraint system. Because with a Groebner basis, it becomes simple
to determine if it is possible to solve this for a given `X`, and also simple to
calculating the "lifting" coefficients (`g_i`) if it is possible.)


## Symmetry considerations

The constraints to be a monochromatic graph are symmetric to node and color relabelling.

Note that this doe NOT mean the polynomial constraints individually have this symmetry.
But it does mean that if you take any constraint polynomial, and apply a relabelling
of the nodes or colors, you will get another polynomial constraining the system.

For example, here is the polynomial defining the constraint for the vertex coloring `(0,0,0,1)`.
```
  w0100*w2301 + w0200*w1301 + w0301*w1200
```
This polynomial is not symmetric to swapping node labels `(2 <--> 3)`, but if we do that we
find the polynomial defining the constraint for the vertex coloring `(0,0,1,0)`.
```
  w0100*w2310 + w0201*w1300 + w0300*w1201
```
Similarly, we could swap the color labels `(0 <--> 1)`. Again the original polynomial
is not symmetric to this change in variables, this now gives the polynomial defining
the constraint for the vertex coloring `(1,1,1,0)`
```
  w0111*w2310 + w0211*w1310 + w0310*w1211
```

(In math terminology, the individual polynomials are not symmetric to these variable permuations,
but the constraint system generated by our polynomial constraints (the ideal generated by our
polynomial constraints) is symmetric to these variable permutations.)

This means if we derive a polynomial constraint like:
```
w0111*w0211*w0311
```
while it means the edge weights `w0111`, `w0211`, `w0311`, at least one must be zero
(ie. in any solution, at least one of those edges cannot be in the graph), it *also* means
(after considering the symmetry) that there cannot be a 3-star of monochrome edges 
(of any color, and centered on any node).



# Calculation results

## g44.s

Taking the general costraints for an n=4 c=4 monochromatic graph,
it is found there is no solution.

## g43.s

Taking the general costraints for an n=4 c=3 monochromatic graph,
it is found that solutions exist and they have the following properties:
- all multi-color weights = 0
- there are no monochrome multi-edges (from constraints `w2311*w2322`)
- there is only one monochrome edge of each color indicident on a node (from constraints like `w1322*w2322`)

Therefore we can see that:
- the mono-chromatic weights are non-zero for only a single perfect matching in each color
- the three mono-chromatic pefect matchings have a disjoint set of edges

In other words, despite allowing complex weights, the solutions for n=4 c=3
are equivalent to the simple solutions using non-negative real values weights:
a coloring of `K_4`, the complete simple graph on 4 nodes.

### This implies the non-existence of an n=4 c=4 monochromatic graph

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

## Lifting results

The above requires trusting the Singular calculation. It would be nice if there
was some way to break it into smaller pieces that can be verified.

One thing that is nice about a lifting calculation, if that the resulting
"coefficients" are like "proof certificate" for the result. Anyone, or any
program, willing to multiply out the polynomial sum can verify the result.

The simpliest is `g42_forbidden_multicolor_3star.s` as it only requires the constraints
from two colors to derive: `w0101*w0201*w0301`.

That could easily be checked by hand. The following however eventually become quite
unreasonable to verify by hand.  So later they will be verified by Mathematica as
an external check.

`g43_forbidden_mixed1_3star.s` shows the constraint `w0312*w1312*w2322`
can be derived from the initial constraints.

`g43_forbidden_mixed2_3star.s` shows the constraint `w0312*w1322*w2322`
can be derived from the initial constraints.

`g43_forbidden_monochrome_3star.s` shows the constraint `w0322*w1322*w2322`
can be derived from the initial constraints.

`g43_forbidden_multicolor_2star.s` helping out the calculation by adding in
the above derived constraints (or symmetry related constraints),
this shows the constraint `w1312*w2312`
can be derived from the initial constraints.


## Deriving g43 results from lifting results

These previous results are derived algebraically from the polynommial constraints.

There are also some combinatorial considerations. In the polynomial constraint
for a multi-color vertex coloring, if one term (which corresponds
to the weight of a perfect matching) is non-zero, then at least one other term
(perfect matching) must also be non-zero if there is any hope for the sum of the
terms to add to zero.

The above lifting results, since they are monomials in the edge weights,
can be interpretted as forbidden subgraphs in an n=4 c=3 monochromatic graph.

Using these forbidden sugraphs, and the combinatorial consideration just mentioned,
it is possible to prove by case analysis that the only g43 solution is a coloring of `K_4`.


## Miscellaneous

`g43_multicolor_contradiction.s` was included just to demonstrate other calculation
option. If a lifting calculation is difficult, instead of asking
"is this polynomial also a constraint?", you could ask
"is a solution possible if I force looking for the subset of solutions that violate that constraint?"

This does not give a nice "proof certificate" like a lifting calculation,
but this approach can allow asking some difficult questions that could not be calculated otherwise.
(In this case, it is computationally feasible to get groebner basis for g43, so it is a bit moot here.
But this is helpful for exploring some questions in monochromatic graphs with `n>4`.)


# Verifying lift results

A python script `extract_for_mathematica.py` was written to extact the polynomial constraints,
and lifting "coefficients" from the output of running a the lifting Singular scripts.

Then `run-math-script.sh` can be used to verify a lift result with Mathematica.

I have found Mathematica to be too memory hungry to do the lift calculations itself,
but verifying the lift results is much easier.  All the lifted results were successfully
verified with Mathematica.

If desired, other computer algebra systems could similarly be used to provide
additional checks the results.


# Running the calculations yourself

## Build Singular

I had to make some modifications to the source, so to use the same setup,
run the script `build_singula.sh` to build on an Ubuntu system (these calculations were done
on an x86-64 system, but I've also used Singular on the arm64 systems on AWS).
If a different operating system is used, the steps on the build script are fairly
self explanatory, the main issue would likely be finding the right packages
for library dependencies.

# Running scripts

Run a Singular script using the supplied wrapper script
```
./run-Singular-script.sh whatever_script.s
```
this will show the results to the console while calculating,
and also save the results to `out_whatever_script.txt`.

# Generate your own scripts

`gen_constraints.py` will generate a Singular script that will calculate a Groebner basis.

It takes two arguments, first the number of nodes, then the number of colors.

For example, to create `g43.s` I ran
```
gen_constraints.py 4 3 > g43.s
```

If you wish to calculate something else, this will at least provide a setup with all the
variable names defined, and all the constraint polynomials listed. So this is usually a
good default to start adding to.

