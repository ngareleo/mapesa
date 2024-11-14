from os.path import join, exists, dirname

class FsHandler:
        
    DIR = join(dirname(__file__), ".store")
    CACHE = join(DIR, "code")
    SMS = join(DIR, "sms")
    SEED = "AAAAAAAAAA"
    
    def __enter__(self):
        return self
    
    def __init__(self):
        if not exists(FsHandler.CACHE):
            print("🪺 Seeding Code Cache")
            with open(FsHandler.CACHE, "w") as f:
                f.write(FsHandler.SEED)
                
        if not exists(FsHandler.SMS):
            raise RuntimeError("Cannot find sms messages. Ask contributors for sample messages")
        
        self.current = self._load()
    
    def __exit__(self, a, b, c):
        self.close()
    
    @property
    def messages(self) -> list:
        mgs = None
        with open(FsHandler.SMS, "r") as f:
            mgs = f.readlines()
        return mgs
        
    def close(self):
        self._write()
        
    def _load(self):
        with open(FsHandler.CACHE, 'r') as file:
            self.current = file.read(10)
        return self.current
        
    def _write(self):
        with open(FsHandler.CACHE, 'w') as file:
            file.write(f"{self.current}")
        
      