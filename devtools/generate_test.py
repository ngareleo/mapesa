import unittest
from generate import CodeFactory

class TestTCodeFactory(unittest.TestCase):

    # with every increment should provide a unique value
    def test_produces_unique_values(self):
        with CodeFactory() as fac: 
            # 10,000 is reasonable limit for the number of times we can generate transactions
            values = [fac.generate() for _ in range(10_000)]
            set_values = set(values)
            self.assertEqual(len(values), len(set_values))
        

if __name__ == '__main__':
    unittest.main()