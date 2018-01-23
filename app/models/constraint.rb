# class CSP
#     """This class describes finite-domain Constraint Satisfaction Problems.
#     A CSP is specified by the following inputs:
#         variables   A list of variables; each is atomic (e.g. int or string).
#         domains     A dict of {var:[possible_value, ...]} entries.
#         neighbors   A dict of {var:[var,...]} that for each variable lists
#                     the other variables that participate in constraints.
#         constraints A function f(A, a, B, b) that returns true if neighbors
#                     A, B satisfy the constraint when they have values A=a, B=b
#     In the textbook and in most mathematical definitions, the
#     constraints are specified as explicit pairs of allowable values,
#     but the formulation here is easier to express and more compact for
#     most cases. (For example, the n-Queens problem can be represented
#     in O(n) space using this notation, instead of O(N^4) for the
#     explicit representation.) In terms of describing the CSP as a
#     problem, that's all there is.
#     However, the class also supports data structures and methods that help you
#     solve CSPs by calling a search function on the CSP. Methods and slots are
#     as follows, where the argument 'a' represents an assignment, which is a
#     dict of {var:val} entries:
#         assign(var, val, a)     Assign a[var] = val; do other bookkeeping
#         unassign(var, a)        Do del a[var], plus other bookkeeping
#         nconflicts(var, val, a) Return the number of other variables that
#                                 conflict with var=val
#         curr_domains[var]       Slot: remaining consistent values for var
#                                 Used by constraint propagation routines.
#     The following methods are used only by graph_search and tree_search:
#         actions(state)          Return a list of actions
#         result(state, action)   Return a successor of state
#         goal_test(state)        Return true if all constraints satisfied
#     The following are just for debugging purposes:
#         nassigns                Slot: tracks the number of assignments made
#         display(a)              Print a human-readable representation
#     """
#
#     def __init__(self, variables, domains, neighbors, constraints):
#         """Construct a CSP problem. If variables is empty, it becomes domains.keys()."""
#         variables = variables or list(domains.keys())
#
#         self.variables = variables
#         self.domains = domains
#         self.neighbors = neighbors
#         self.constraints = constraints
#         self.initial = ()
#         self.curr_domains = None
#         self.nassigns = 0
#
#     def assign(self, var, val, assignment):
#         """Add {var: val} to assignment; Discard the old value if any."""
#         assignment[var] = val
#         self.nassigns += 1
#
#     def unassign(self, var, assignment):
#         """Remove {var: val} from assignment.
#         DO NOT call this if you are changing a variable to a new value;
#         just call assign for that."""
#         if var in assignment:
#             del assignment[var]
#
#     def nconflicts(self, var, val, assignment):
#         """Return the number of conflicts var=val has with other variables."""
#         # Subclasses may implement this more efficiently
#         def conflict(var2):
#             return (var2 in assignment and
#                     not self.constraints(var, val, var2, assignment[var2]))
#         return count(conflict(v) for v in self.neighbors[var])
