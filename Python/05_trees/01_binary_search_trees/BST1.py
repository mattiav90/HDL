

# This is an implementation of bianry tree.
# I will write a class to create a node in the tree.
# Then functions to create a tree from a list of values
# and a search binary

class Node:
    #tbhis is the init of the node
    def __init__(self,val=0,left=None,right=None):
        self.val=val
        self.left=left
        self.right=right

    #this is to print a node recursively
    def __repr__(self):
        left_str = repr(self.left) if self.left else "None"
        right_str = repr(self.right) if self.right else "None"
        return f"({self.val}, L={left_str}, R={right_str})"

# This is to insert a single element
def insert(root,val):
    if root is None:
        return Node(val)
    elif root.val<val:
        root.right = insert(root.right,val)
    elif root.val>val:
        root.left = insert(root.left,val)
    return root




# This function builds a tree from a list 
def build_tree_from_list(data):
    root=None
    for d in data:
        root = insert(root,d)
    return root


# this is a seach binary using recursion in a tree.
def search(root,val):

    if root is None:
        return None
    if root.val==val:
        return root
    elif root.val<val:
        return search(root.right,val)
    elif root.val>val:
        return search(root.left,val)
        

# I need to also implement deletion.
# deletion is the most complicated element of the binary tree. 

def remove(root,val):

    if not root:
        return None

    #find the target node
    if val<root.val:
        root.left=remove(root.left,val)
    elif val>root.val:
        root.right=remove(root.right,val)

    #once the node is found
    else:
        #if the node has 0 or 1 child
        if root.right==None:
            return root.left
        #if the node has 0 or 1 child
        elif root.left==None:
            return root.right

        #if the node has 2 children
        #find the minimu in the right branch
        #then replace the target node with the detected minimum
        else:
            cur=root.right
            while cur.left:
                cur=root.left
            root.val=cur.val
            remove(root.right,cur.val)

    return root



# this is the main, just to test a couple of exmaples.
if __name__=="__main__":
        
    data=[[1,4,7,2,5,6,3,8,],[1,4,7,2,3,8,]]
    val=[2,1]


    for i in range(len(data)):
        print("-"*100)
        root=build_tree_from_list(data[i])
        print("root: ",root)
        out= search(root,val[i])
        print("out: ",out)
        out = remove(root,7)
        print("remove: ",out)
