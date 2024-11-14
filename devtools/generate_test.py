import unittest
from generate import CodeFactory

class TestTCodeFactory(unittest.TestCase):

    def test_increment(self):
        with CodeFactory() as fac: 
            get_value = fac.value
            initial_code = fac.current
            new_code = fac.increment()
            self.assertEqual(get_value(new_code), get_value(initial_code) + 1)

    # with every increment should provide a unique value
    def test_produces_unique_values(self):
        with CodeFactory() as fac: 
            # 10,000 is reasonable limit for the number of times we can generate transactions
            values = [fac.increment() for _ in range(10_000)]
            set_values = set(values)
            self.assertEqual(len(values), len(set_values))
        

if __name__ == '__main__':
    unittest.main()