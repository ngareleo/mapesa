from enum import Enum
from random import choice, randrange
from fs import FsHandler


class MessageGenerator:
    
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

    def __init__(self, fs: FsHandler):
        self.fs = fs
        
    def __enter__(self):
        return self
    
    def __exit__(self, a, b, c):
        self.fs.close()
        
    def new(self) -> str: 
        cls = MessageGenerator.MessageType
        
        templates = {
            cls.AIRTIME: self._generate_airtime,
            cls.AIRTIME_FOR: self._generate_airtime_for,
            cls.DEPOSIT: self._generate_deposit,
            cls.FULIZA:self._generate_fuliza,
            cls.LIPA: self._generate_lipa,
            cls.PAYBILL: self._generate_paybill,
            cls.RECEIVE: self._generate_receive,
            cls.SEND: self._generate_send,
            cls.WITHDRAW: self._generate_withdraw
        }
        
        mtype = choice(list(MessageGenerator.MessageType))
        return (templates[mtype])()
    
    def generate_mpesa_code(self) -> str:
        next = int(self.fs.current, 16) + 1
        self.fs.current = format(next, 'X')
        return self.fs.current

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
        code = self.generate_mpesa_code()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

    def _generate_airtime_for(self): 
        # Todo: Replace with actual template
        code = self.generate_mpesa_code()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

    def _generate_deposit(self):
        # Todo: Replace with actual template
        code = self.generate_mpesa_code()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

    def _generate_fuliza(self):
        code = self.generate_mpesa_code()
        amount = self._generate_amount()
        interest = self._generate_transaction_cost()
        outstanding = self._generate_amount()
        due_date = self._generate_random_date()
        return f"{code} Confirmed. Fuliza M-PESA amount is {amount}. Interest charged {interest}. Total Fuliza M-PESA outstanding amount is {outstanding} due on {due_date}. To check daily charges, Dial *234*0#OK Select Query Charges"

    def _generate_lipa(self):
        code = self.generate_mpesa_code()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        subject = self._generate_random_subject()
        cost = self._generate_transaction_cost()
        return f"{code} Confirmed. {amount} paid to {subject}. on {date} at {time}. New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 497,796.00. To move money from bank to M-PESA, dial *334#>Withdraw>From bank to MPESA"

    def _generate_paybill(self):
        code = self.generate_mpesa_code()
        amount = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        balance = self._generate_amount()
        subject = self._generate_random_subject()
        account = self._generate_random_account()
        return f"{code} Confirmed. {amount} sent to {subject} for account {account} on {date} at {time} New M-PESA balance is {balance}"

    def _generate_receive(self):
        code = self.generate_mpesa_code()
        amount = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        balance = self._generate_amount()
        subject = self._generate_random_subject()
        account = self._generate_random_account()
        return f"{code} Confirmed. You have received {amount} from {subject} {account} on {date} at {time} New M-PESA balance is {balance}. Separate personal and business funds through Pochi la Biashara on *334#"

    def _generate_send(self):
        code = self.generate_mpesa_code()
        amount = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        balance = self._generate_amount()
        cost = self._generate_transaction_cost()
        name = self._generate_random_name()
        return f"{code} Confirmed. {amount} sent to {name} on {date} at {time}. New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,880.00. To receive Money on POCHI today dial *334# & opt in."

    def _generate_withdraw(self):
        # Todo: Replace with actual template
        code = self.generate_mpesa_code()
        cost = self._generate_transaction_cost()
        amount = self._generate_amount()
        balance = self._generate_amount()
        date = self._generate_random_date()
        time = self._generate_random_time()
        return f"{code} confirmed.You bought {amount} of airtime on {date} at {time}.New M-PESA balance is {balance}. Transaction cost, {cost}. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

