import unittest
from devtools.fs import FsHandler
import os

class TestFsHandler(unittest.TestCase):

    def setUp(self):
        self.handler = FsHandler()
        self.handler.DIR = os.path.join(os.path.dirname(__file__), ".test_store")
        self.handler.CACHE = os.path.join(self.handler.DIR, "code")
        self.handler.SMS = os.path.join(self.handler.DIR, "sms")
        if not os.path.exists(self.handler.DIR):
            os.makedirs(self.handler.DIR)
        with open(self.handler.CACHE, "w") as f:
            f.write(FsHandler.SEED)
        with open(self.handler.SMS, "w") as f:
            f.write("Sample SMS message")

    def tearDown(self):
        if os.path.exists(self.handler.DIR):
            for file in os.listdir(self.handler.DIR):
                os.remove(os.path.join(self.handler.DIR, file))
            os.rmdir(self.handler.DIR)

    def test_initial_seed(self):
        with FsHandler() as fs:
            self.assertEqual(fs.current, FsHandler.SEED)

    def test_load_method(self):
        with FsHandler() as fs:
            self.assertEqual(fs._load(), FsHandler.SEED)

    def test_write_method(self):
        with FsHandler() as fs:
            fs.current = "BBBBBBBBBB"
            fs._write()
            self.assertEqual(fs._load(), "BBBBBBBBBB")

    def test_messages_property(self):
        with FsHandler() as fs:
            self.assertEqual(fs.messages, ["Sample SMS message"])

if __name__ == '__main__':
    unittest.main()