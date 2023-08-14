class Node:
    def __init__(self, value=None):
        self.next = None
        self.prev = None
        self.value = value

    def link_after(self, node):
        if self.next or self.prev:
            raise ValueError("Already in a list")
        self.prev = node
        if node.next:
            node.next.prev = self
        self.next = node.next
        node.next = self

    def link_before(self, node):
        if self.next or self.prev:
            raise ValueError("Already in a list")
        self.next = node
        if node.prev:
            node.prev.next = self
        self.prev = node.prev
        node.prev = self


    def remove(self):
        """Unlinks the node but preserves the list structure."""
        if self.prev:
            self.prev.next = self.next
        if self.next:
            self.next.prev = self.prev
        self.prev = None
        self.next = None

    def split(self):
        """Splits the list structure into two with the node at the start of new one."""
        if self.prev:
            self.prev.next = None
            self.prev = None


class DLinkedList():
    def __init__(self):
        self.head = None
        self.tail = None

    def append(self, value):
        new_node = Node(value)
        if not self.head:
            self.head = self.tail = new_node
            return
        new_node.prev = self.tail
        self.tail.next = new_node
        self.tail = new_node

    def appendleft(self, value):
        new_node = Node(value)
        if not self.tail:
            self.head = self.tail = new_node
            return
        new_node.next = self.head
        self.head.prev = new_node
        self.head = new_node

    def pop(self):
        if self.tail is None:
            raise IndexError("No elements in linked list")
        node = self.tail
        self.tail = node.prev
        node.remove()
        if self.head == node:
            self.head = None
        return node.value

    def peek(self):
        if self.tail is None:
            raise IndexError("No elements in linked list")
        return self.tail.value

    def find_node(self, target_value):
        if not self.head:
            return None
        node = self.head
        while node.value != target_value:
            if not node.next:
                return None
            node = node.next
        return node

    def find_node_at(self, n):
        if not isinstance(n, int):
            raise TypeError("%s is not an integer" % n)
        if not self.head:
            raise IndexError("No elements in linked list")
        node = self.head
        for _ in range(n):
            node = node.next
            if not node:
                raise IndexError("List does not contain %s elements" % n)
        return node

    def index(self, target):
        n = self.find_node(target)
        if not n:
            raise ValueError("Value %s not in list" % target)
        return n.value

    def split_at_node(self, node):
        new_list = DLinkedList()
        new_list.tail = self.tail
        new_list.head = node

        node.split()

        self.tail = node.prev
        if self.head is node:
            self.head = None
        return new_list

    def split_at(self, idx):
        node = self.find_node_at(idx)
        return self.split_at_node(node)

    def __getitem__(self, key):
        return self.find_node_at(key).value

    def to_list(self):
        values = []
        node = self.head
        while node:
            values.append(node.value)
            node = node.next
        return values


def create_linked_list(values):
    l = DLinkedList()
    for v in values:
        l.append(v)
    return l
