# Implementation of B+-tree functionality.

from index import *

# You should implement all of the static functions declared
# in the ImplementMe class and submit this (and only this!) file.
class ImplementMe:

    # Returns a B+-tree obtained by inserting a key into a pre-existing
    # B+-tree index if the key is not already there. If it already exists,
    # the return value is equivalent to the original, input tree.
    #
    # Complexity: Guaranteed to be asymptotically linear in the height of the tree
    # Because the tree is balanced, it is also asymptotically logarithmic in the
    # number of keys that already exist in the index.
    @staticmethod
    def InsertIntoIndex( index, key ):
        if (index == Index()):
            index = Index(Node(KeySet([key, None]),PointerSet([None]*3)))
        if (LookupKeyInNode(index.root, key) == True):
            return index
        return index

    # Returns a boolean that indicates whether a given key
    # is found among the leaves of a B+-tree index.
    #
    # Complexity: Guaranteed not to touch more nodes than the
    # height of the tree
    @staticmethod
    def LookupKeyInIndex( index, key ):
        return LookupKeyInNode(index.root, key)

    # Returns a list of keys in a B+-tree index within the half-open
    # interval [lower_bound, upper_bound)
    #
    # Complexity: Guaranteed not to touch more nodes than the height
    # of the tree and the number of leaves overlapping the interval.
    @staticmethod
    def RangeSearchInIndex( index, lower_bound, upper_bound ):
        return RangeSearchInNode(index.root, lower_bound, upper_bound)


def RangeSearchInNode(node, lower_bound, upper_bound):
    result = []
        
    if (len(node.pointers.pointers) > 0 and (node.pointers.pointers[0] is not None and\
        not node.keys.keys[0] is None and node.keys.keys[0] > lower_bound)):
        return RangeSearchInNode(node.pointers.pointers[0], lower_bound, upper_bound)
    elif (len(node.pointers.pointers) > 1 and \
        (node.pointers.pointers[1] is not None and node.keys.keys[1] is not None and node.keys.keys[1] > lower_bound or \
        node.pointers.pointers[0] is not None and node.keys.keys[0] is not None and node.keys.keys[0] <= lower_bound)):
        return RangeSearchInNode(node.pointers.pointers[1], lower_bound, upper_bound)
    elif (len(node.pointers.pointers) > 2 and node.pointers.pointers[2] is not None and node.pointers.pointers[1] is not None):
        return RangeSearchInNode(node.pointers.pointers[2], lower_bound, upper_bound)
    
    return GetList(node, lower_bound, upper_bound, result)
    
def GetList(node, lower_bound, upper_bound, result):
    
    for key in node.keys.keys:
        if (key is not None and lower_bound < key and key < upper_bound):
            result.append(key)
        elif (key is not None and key > upper_bound):
            return result
    
    if (len(node.pointers.pointers) > 2 and node.pointers.pointers[2] is not None and node.pointers.pointers[1] is None):
        return GetList(node.pointers.pointers[2], lower_bound, upper_bound, result)
    return result


def LookupKeyInNode(node, key):
        for keys in node.keys.keys:
            if (key == keys):
                return True
        if (len(node.pointers.pointers) > 0 and (node.pointers.pointers[0] is not None and not node.keys.keys[0] is None and node.keys.keys[0] > key)):
            return LookupKeyInNode(node.pointers.pointers[0], key)
        elif (len(node.pointers.pointers) > 1 and \
            (node.pointers.pointers[1] is not None and node.keys.keys[1] is not None and node.keys.keys[1] > key or \
            node.pointers.pointers[0] is not None and node.keys.keys[0] is not None and node.keys.keys[0] <= key)):
            return LookupKeyInNode(node.pointers.pointers[1], key)
        elif (len(node.pointers.pointers) > 2 and node.pointers.pointers[2] is not None and node.pointers.pointers[1] is not None):
            return LookupKeyInNode(node.pointers.pointers[2], key)
        return False
