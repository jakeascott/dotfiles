import unittest


class Test(unittest.TestCase):
    def setUp(self):
        # runs berfore each test
        pass

    def tearDown(self):
        # runs after each test
        pass

    @classmethod
    def setUpClass(cls):
        # Runs once before any tests
        pass

    @classmethod
    def tearDownClass(cls):
        # Runs once after all tests
        pass


if __name__ == "__main__":
    unittest.main()

