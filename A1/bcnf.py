# Counts the number of steps required to decompose a relation into BCNF.

from relation import *
from functional_dependency import *

# You should implement the static function declared
# in the ImplementMe class and submit this (and only this!) file.
# You are welcome to add supporting classes and methods in this file.
class ImplementMe:

    # Returns the number of recursive steps required for BCNF decomposition
    #
    # The input is a set of relations and a set of functional dependencies.
    # The relations have *already* been decomposed.
    # This function determines how many recursive steps were required for that
    # decomposition or -1 if the relations are not a correct decomposition.
    @staticmethod
    def DecompositionSteps( relations, fds ):
        R = set()
        RCount = 0
        answer = 0
        
        for r in relations.relations:
            R |= r.attributes
            RCount += 1
            
        answer += BCNF(relations, fds, R)
        
        print(answer)
        print(RCount)
        
        if(RCount == answer):
            return RCount - 1
        else:
            return -1
        
#Check if it's possible to get relations set from R
def BCNF(relations, fds, R):
    LHS = set()
    RHS = set()
    check = set()
        
    for fd in fds.functional_dependencies:
        LHS |= fd.left_hand_side
        RHS |= fd.right_hand_side
        if (LHS <= R and RHS <= R):
            check |= LHS | RHS
            if(not SuperKey(R, fds, check)):
                R1 = closure(fds, LHS)
                R2 = (R - R1) | LHS
                F1 = ProjectFd(R1, fds)
                F2 = ProjectFd(R2, fds)
                return BCNF (relations, fds, R1) + BCNF(relations, fds, R2)
        
        check.clear() 
        LHS.clear()
        RHS.clear()
    for r in relations.relations:
        if(R <= r.attributes and r.attributes <= R):
            return 1
        
    return 0

# calculate fd of relation R
def ProjectFd(R1, fds):
    temp = set()
    
    for fd in fds.functional_dependencies:
        if (fd.left_hand_side <= R1 and fd.right_hand_side <= R1):
            temp.add(fd)
    
    f = FDSet(temp.copy())
    return f
    
# calculate closure of a fd    
def closure(fds, LHS):
    R1 = LHS.copy()
    
    for fd in fds.functional_dependencies:
        if(len(fd.left_hand_side - R1) == 0 and len(fd.right_hand_side - R1) != 0):
            R1 |= fd.right_hand_side
            return closure(fds, R1)
        
    return R1
    

# check if check (left hand side of a fds) is a superkey of relation R
def SuperKey(R, fds, check):
    LHS = set()
    RHS = set()
    CurRelation = set() 
    CurRelation |= R

    
    for fd in fds.functional_dependencies:
        LHS |= fd.left_hand_side
        RHS |= fd.right_hand_side
        if (LHS <= check and len(RHS - check) != 0):
            check |= RHS
            return SuperKey(CurRelation, fds, check)
        
        LHS.clear()
        RHS.clear()
        
    CurRelation -= check
    if (len(CurRelation) == 0):
        return True
    else:
        return False
