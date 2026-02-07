# reverse a linked list iteratively and recursively.


class LinkedList:
    def __init__(self,val=0,next=None):
        self.val=val
        self.next=next



#this implementation basically reverse from the beginning all the way to the end
def reverse_iterative(head):

    pre=None 
    curr=head

    while curr:
        nxt=curr.next
        curr.next=pre
        pre=curr
        curr=nxt
    
    return pre


# this implementation reverse starting from the end all the way back to the beginning. 
def reverse_recursive(head):

    if head.next==None:
        return head

    new_head=reverse_recursive(head.next)
    head.next.next=head
    head.next=None
    
    return new_head




def printList(head):
    while head:
        print(head.val, end=" -> ")
        head=head.next
    print("None")




node0=LinkedList(0)
node1=LinkedList(1,node0)
node2=LinkedList(2,node1)
node3=LinkedList(3,node2)
head =LinkedList(4,node3)



printList(head)
new_head = reverse_iterative(head)
printList(new_head)
new_head = reverse_recursive(new_head)
printList(new_head)



