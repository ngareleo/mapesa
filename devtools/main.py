import click 
from telnetlib import Telnet
from enum import Enum
import os

mpesa_messages = open(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "sample_sms.txt"),
    "r",
).readlines()

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
    
def generate_airtime():
    return {}

def generate_airtime_for(): 
    return {}

def generate_deposit():
    return {}

def generate_fuliza():
    return {}

def generate_lipa():
    return {}

def generate_paybill():
    return {}

def generate_receive():
    return {}

def generate_send():
    return {}

def generate_withdraw():
    return {}

def generate_mpesa_message(mtype: MessageType): 
    templates = {
        MessageType.AIRTIME: ("", generate_airtime),
        MessageType.AIRTIME_FOR: ("Confirmed. Ksh{} sent to {} for airtime.", generate_airtime_for),
        MessageType.DEPOSIT: ("Confirmed. Ksh{} deposited to your account.", generate_deposit),
        MessageType.FULIZA: ("Confirmed. Ksh{} Fuliza loan taken.", generate_fuliza),
        MessageType.LIPA: ("Confirmed. Ksh{} paid via Lipa na M-PESA.", generate_lipa),
        MessageType.PAYBILL: ("Confirmed. Ksh{} paid to {} via Paybill.", generate_paybill),
        MessageType.RECEIVE: ("Confirmed. Ksh{} received from {}.", generate_receive),
        MessageType.SEND: ("Confirmed. Ksh{} sent to {}.", generate_send),
        MessageType.WITHDRAW: ("Confirmed. Ksh{} withdrawn from your account.", generate_withdraw)
    }
    template, d = templates[mtype]
    return template.format(d)


@click.group()
def devtools():
    pass


@devtools.command()
def send():
    """
    Should send a randomly chosen generated MPESA message to the online VM
    """
    example = "RJP5FWG77X Confirmed. Ksh100.00 paid to PETER MWANGI. on 25/10/23 at 8:37 AM.New M-PESA balance is Ksh0.00. Transaction cost, Ksh0.00. Amount you can transact within the day is 499,800.00. To move money from bank to M-PESA, dial *334#>Withdraw>From bank to MPESA"
    
    with Telnet("localhost", 5554) as telnet_connection:
        connect_msg = telnet_connection.read_until(b"OK").decode("utf-8")
        click.echo(connect_msg)
        auth_file_fs = connect_msg.split("\n")[3].strip()[1:-1]
        with open(auth_file_fs, "r") as f:
            # auth into the vm
            auth_code = f.read()
            telnet_connection.write(b"auth " + auth_code.encode("utf-8") + b"\n")            
            
            # send message
            telnet_connection.write(b"sms send MPESA " + example.encode("utf-8"))
    
            # write back into stdout 
            click.echo(telnet_connection.read_until(b"OK").decode("utf-8"))
            
            # quit telnet
            telnet_connection.write(b"exit\r\n")
            telnet_connection.write(b"q\r\n")

    

@devtools.command()
def init():
    """
    Flood VM with MPESA messages
    """
    with Telnet("localhost", 5554) as telnet_connection:
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