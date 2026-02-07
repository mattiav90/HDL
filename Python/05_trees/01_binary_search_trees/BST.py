
        

class Node:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def insert(root, val):
    if root is None:
        return Node(val)
    if val < root.val:
        root.left = insert(root.left, val)
    else:
        root.right = insert(root.right, val)
    return root

def build_bst_from_list(values):
    root = None
    for val in values:
        root = insert(root, val)
    return root

def search(root,val):

    if root==None:
        return None

    if root.val==val:
        return root
    elif root.val<val:
        return search(root.right,val)
    elif root.val>val:
        return search(root.left,val)




# Example usage
if __name__ == "__main__":
    print("BST")

    data = [[4, 2, 7, 1, 3], [4, 2, 7, 1, 3]]
    val = [2, 4]

    for i in range(len(data)):
        tree = build_bst_from_list(data[i])
        out = search(tree, val[i])
        print("Found subtree rooted at:", out.val if out else None)
