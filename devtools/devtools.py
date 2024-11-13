import click 
from telnetlib import Telnet
from random import choice
from enum import Enum
from os import path

CODES_CACHE=path.join(path.dirname(path.abspath(__file__)), ".cache", "codes")
MPESA_MSGS_FILE=path.join(path.dirname(path.abspath(__file__)), "sample_sms")

codes_cache_file = open(CODES_CACHE, "rw")
mpesa_messages = open(MPESA_MSGS_FILE, "r").readlines()

   
class FsHandler:
    def __init__(self):
        self.latest_code = int(codes_cache_file.read()[:-10])
    
    @classmethod
    def close_files(cls, func):
        def close_after_execute():
            func()
            codes_cache_file.close()
        return close_after_execute

    def increment(self):
        after = int(self.latest_code, 16) + 1
        after0 = format(after, 'x')
        self.latest_code = after0
        codes_cache_file.write(after0.encode())    
    

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
    
    
class MessageGenerator:
    def __init__(self):
        self.fs = FsHandler()
        
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
        
    def _generate_transaction_id(self):
        pass
        
    def _generate_airtime(self):
        code = self.fs.increment()
        return f"{code} confirmed.You bought Ksh50.00 of airtime on 2/11/23 at 6:04 PM.New M-PESA balance is Ksh1,820.48. Transaction cost, Ksh0.00. Amount you can transact within the day is 499,770.00. Dial *234*0# to Opt in to FULIZA and check your limit."

    def _generate_airtime_for(self): 
        return {}

    def _generate_deposit(self):
        return {}

    def _generate_fuliza(self):
        return {}

    def _generate_lipa(self):
        return {}

    def _generate_paybill(self):
        return {}

    def _generate_receive(self):
        return {}

    def _generate_send(self):
        return {}


    def _generate_withdraw(self):
        return {}


@FsHandler.close_files
@click.group()
def devtools():
    """
    Application entry point
    """
    pass


@devtools.command()
def send():
    """
    Should send a randomly chosen generated MPESA message to the online VM. 
    
    Usage: Can be used to simulate incoming
    MPESA notification
    """
    gen = MessageGenerator()
    message = gen.new()
    
    with Telnet("localhost", 5554) as telnet_connection:
        
        # spit back to stdout
        connect_msg = telnet_connection.read_until(b"OK").decode("utf-8")
        click.echo(connect_msg)
        
        auth_file_fs = connect_msg.split("\n")[3].strip()[1:-1]
        with open(auth_file_fs, "r") as f:
            # auth into the vm
            auth_code = f.read()
            telnet_connection.write(b"auth " + auth_code.encode("utf-8") + b"\n")            
            
            # send message
            telnet_connection.write(b"sms send MPESA " + message.encode("utf-8"))
    
            # write back into stdout 
            click.echo(telnet_connection.read_until(b"OK").decode("utf-8"))
            
            # quit telnet
            telnet_connection.write(b"exit\r\n")
            telnet_connection.write(b"q\r\n")

    

@devtools.command()
def init():
    """
    Flood VM with MPESA messages. 
    
    Usage: To onboard messages onto a VM
    """
    with Telnet("localhost", 5554) as telnet_connection:
        # spit back to stdout
        connect_msg = telnet_connection.read_until(b"OK").decode("utf-8")
        click.echo(connect_msg)
        
        auth_file_fs = connect_msg.split("\n")[3].strip()[1:-1]
        with open(auth_file_fs, "r") as f:
            # auth into the vm
            auth_code = f.read()
            telnet_connection.write(b"auth " + auth_code.encode("utf-8") + b"\n")

            # write all the messages into the VM
            for i, message in enumerate(mpesa_messages):
                click.echo("[i] : Sending message {} of {}".format(i + 1, len(mpesa_messages)))
                telnet_connection.write(b"sms send MPESA " + message.encode("utf-8"))
                click.echo(telnet_connection.read_until(b"OK").decode("utf-8"))
                click.echo("Send success!")

            # quit telnet
            telnet_connection.write(b"exit\r\n")
            telnet_connection.write(b"q\r\n")
    
    click.echo("\n\n❤️ Welcome to the team dev! ❤️")
    
    
if __name__ == "__main__":
    devtools()