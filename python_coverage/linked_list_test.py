import linked_list as ll

import unittest

class LinkedListTest(unittest.TestCase):

    def test_simple_append(self):
        arr = [4, 5, 1, 2, 7, 8]
        l = ll.DLinkedList()
        for v in arr:
            l.append(v)
        self.assertEquals(arr, l.to_list())

    def test_split(self):
        arr = [1, 2, 3, 4, 5, 6, 7]
        l = ll.create_linked_list(arr)
        nl = l.split_at(4)

        self.assertEquals([1, 2, 3, 4], l.to_list())
        self.assertEquals([5, 6, 7], nl.to_list())



if __name__ == "__main__":
  unittest.main()
