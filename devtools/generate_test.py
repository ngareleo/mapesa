import unittest
from generate import FsHandler

class TestTCodeFactory(unittest.TestCase):

    # with every increment should provide a unique value
    def test_produces_unique_values(self):
        with FsHandler() as fs: 
            # 10,000 is reasonable limit for the number of times we can generate transactions
            values = [fs.generate() for _ in range(10_000)]
            set_values = set(values)
            self.assertEqual(len(values), len(set_values))
        

if __name__ == '__main__':
    unittest.main()