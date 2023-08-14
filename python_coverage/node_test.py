import linked_list as ll

import unittest

class NodeTest(unittest.TestCase):

    def walk_list(self, node):
        seen = set()
        values = []
        while node and node not in seen:
            print(node)
            seen.add(node)
            values.append(node.value)
            node = node.next
        return values

    def test_link_after(self):
        zero = ll.Node(0)
        one = ll.Node(1)
        two = ll.Node(2)
        one.link_after(zero)
        two.link_after(one)
        self.assertEquals([0, 1, 2], self.walk_list(zero))

    def test_link_before(self):
        zero = ll.Node(0)
        one = ll.Node(1)
        two = ll.Node(2)
        one.link_before(zero)
        two.link_before(one)
        self.assertEquals([2, 1, 0], self.walk_list(two))


if __name__ == "__main__":
  unittest.main()

