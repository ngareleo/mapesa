from enum import Enum
from random import choice, randrange
from os.path import join, exists, dirname

class MessageType(Enum):
    AIRTIME_FOR = 0
    AIRTIME=1
    DEPOSIT=2
    FULIZA=3
    LIPA=4
    PAYBILL=5
    RECEIVE=6
    SEND=7
    WITHDRAW=8

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
        
        self._current = self.load()
    
    def __exit__(self, a, b, c):
        self.close()
        
    @property
    def current(self) -> str:
        return self._current
    
    @property
    def messages(self) -> list:
        mgs = None
        with open(FsHandler.SMS, "r") as f:
            mgs = f.readlines()
        return mgs
        
    def close(self):
        self.write()
        
    def load(self):
        with open(FsHandler.CACHE, 'r') as file:
            self._current = file.read(10)
        return self._current
        
    def write(self):
        with open(FsHandler.CACHE, 'w') as file:
            file.write(f"{self._current}")
        
    def value(self, v: str) -> int:
        """
        Should return unique decimal repr of the code.
        """
        return int(v, 16)
    

        
    def generate(self) -> str:
        next = self.value(self._current) + 1
        self._current = format(next, 'X')
        return self._current
        
        
class MessageGenerator:
    def __init__(self, fs: FsHandler):
        self.fs = fs
        
    def __enter__(self):
        return self
    
    def __exit__(self, a, b, c):
        self.fs.close()
        
    def new(self, m: MessageType) -> str: 
        templates = {
            MessageType.AIRTIME: self._generate_airtime,
            MessageType.AIRTIME_FOR: self._generate_airtime_for,
            MessageType.DEPOSIT: self._generate_deposit,
            MessageType.FULIZA:self._generate_fuliza,
            MessageType.LIPA: self._generate_lipa,
            MessageType.PAYBILL: self._generate_paybill,
            MessageType.RECEIVE: self._generate_receive,
            MessageType.SEND: self._generate_send,
            MessageType.WITHDRAW: self._generate_withdraw
        }
        return (templates[m])()

    @staticmethod
    def _generate_random_date():
        return f"{randrange(0, 29)}/{randrange(0, 12)}/{randrange(20, 25)}"

    @staticmethod
    def _generate_random_time():
        return f"{randrange(0, 12)}:{randrange(0, 59)} {choice(["AM", "PM"])}"

    @staticmethod
    def _generate_amount():
        return f"Ksh{randrange(0, 8_000_000, 10) / 100:,.2f}"

    @staticmethod
    def _generate_transaction_cost():
        # Todo: Generate amount and cost side by side to ensure sensible messages
        return f"Ksh{randrange(0, 500, 10) / 100:,.2f}"

    @staticmethod
    def _generate_random_name():
        firstname = choice(["JANE", "TIFANNY", "ALEX", "ANDREW", "HILDA", "MAUREEN"])
        lastname = choice(["MURAGE", "MWENI", "ODONGO", "SIMIUYU", "CHACHA", "KALONZO", "CHEPTOO"])
        return f"{firstname} {lastname}"

    @staticmethod
    def _generate_random_subject():
        return choice(["KFC Garden City", "Omari Sport Goods", "Carrefour TWO RIVERS"])

    @staticmethod
    def _generate_random_account():
        return f"{randrange(100_000, 999_999)}"
        
    def _generate_airtime(self):
        code = self.fs.generate()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

    def _generate_airtime_for(self): 
        # Todo: Replace with actual template
        code = self.fs.generate()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

    def _generate_deposit(self):
        # Todo: Replace with actual template
        code = self.fs.generate()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

    def _generate_fuliza(self):
        code = self.fs.generate()
        amount = self._generate_amount()
        interest = self._generate_transaction_cost()
        outstanding = self._generate_amount()
        due_date = self._generate_random_date()
        return f"{code} Confirmed. Fuliza M-PESA amount is {amount}. Interest charged {interest}. Total Fuliza M-PESA outstanding amount is {outstanding} due on {due_date}. To check daily charges, Dial *234*0#OK Select Query Charges"

    def _generate_lipa(self):
        code = self.fs.generate()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        subject = self._generate_random_subject()
        cost = self._generate_transaction_cost()
        return f"{code} Confirmed. {amount} paid to {subject}. on {date} at {time}. New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 497,796.00. To move money from bank to M-PESA, dial *334#>Withdraw>From bank to MPESA"

    def _generate_paybill(self):
        code = self.fs.generate()
        amount = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        balance = self._generate_amount()
        subject = self._generate_random_subject()
        account = self._generate_random_account()
        return f"{code} Confirmed. {amount} sent to {subject} for account {account} on {date} at {time} New M-PESA balance is {balance}"

    def _generate_receive(self):
        code = self.fs.generate()
        amount = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        balance = self._generate_amount()
        subject = self._generate_random_subject()
        account = self._generate_random_account()
        return f"{code} Confirmed. You have received {amount} from {subject} {account} on {date} at {time} New M-PESA balance is {balance}. Separate personal and business funds through Pochi la Biashara on *334#"

    def _generate_send(self):
        code = self.fs.generate()
        amount = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        balance = self._generate_amount()
        cost = self._generate_transaction_cost()
        name = self._generate_random_name()
        return f"{code} Confirmed. {amount} sent to {name} on {date} at {time}. New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,880.00. To receive Money on POCHI today dial *334# & opt in."

    def _generate_withdraw(self):
        # Todo: Replace with actual template
        code = self.fs.generate()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

