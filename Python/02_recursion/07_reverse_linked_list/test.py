#reverse a linked list, both iterative and recursive solution.



class ListNode:
    def __init__(self,val=0,next=None):
        self.val=val
        self.next=next



# reverse a linked list with iterations
def reverse_iterative(head):

    pre=None
    curr=head

    while curr:
        nxt=curr.next
        curr.next=pre
        pre=curr
        curr=nxt

    return pre



# reverse recursively a linked list.
def reverse_recursive(head):
    if not head or not head.next:
        return head

    new_head = reverse_recursive(head.next)
    head.next.next=head
    head.next=None

    return new_head

    

    
    



def printList(head):
    while head:
        print(head.val, end=" -> ")
        head=head.next
    print("None")


node0 = ListNode(0)
node1 = ListNode(1,node0)
node2 = ListNode(2,node1)
node3 = ListNode(3,node2)
head  = ListNode(4,node3)


printList(head)

new_head=reverse_iterative(head)
printList(new_head)

new_head=reverse_recursive(new_head)
printList(new_head)



