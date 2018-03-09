from cron import next_time
import unittest

class TestProgram(unittest.TestCase):
    def testnext_time(self):
        self.assertEqual(next_time('*','*', 0, 0), (0,0,False))
        self.assertEqual(next_time('*','*', 1, 1), (1,1,False))
        self.assertEqual(next_time('*','*', 23, 59), (23,59,False))
        self.assertEqual(next_time(23,59, 23, 59), (23,59,False))
        self.assertEqual(next_time(23,58, 23, 59), (23,58,True))
        self.assertEqual(next_time(23,59, 23, 58), (23,59,False))
        self.assertEqual(next_time(23,59, 0, 0), (23,59,False))
        self.assertEqual(next_time('*',58, 23, 59), (0,58,True))
        self.assertEqual(next_time(1,'*', 23, 59), (1,0,True))
        self.assertEqual(next_time(1,'*', 0, 59), (1,0,False))
        self.assertEqual(next_time(0,'*', 1, 0), (0,0,True))
        self.assertEqual(next_time(0,'*', 1, 15), (0,0,True))
        self.assertEqual(next_time(1,'*', 0, 0), (1,0,False))
        self.assertEqual(next_time(1,'*', 0, 15), (1,0,False))
        self.assertEqual(next_time('*',59, 0, 59), (0,59,False))
        self.assertEqual(next_time('*',58, 0, 59), (1,58,False))


