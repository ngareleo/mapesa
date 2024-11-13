import click 
from telnetlib import Telnet
from random import choice
from enum import Enum
from os import path

samples_fn = path.join(path.dirname(path.abspath(__file__)), "sample_sms")
mpesa_messages = open(samples_fn, "r").readlines()

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

def generate_mpesa_message(m: MessageType): 
    templates = {
        MessageType.AIRTIME: generate_airtime,
        MessageType.AIRTIME_FOR: generate_airtime_for,
        MessageType.DEPOSIT: generate_deposit,
        MessageType.FULIZA: generate_fuliza,
        MessageType.LIPA: generate_lipa,
        MessageType.PAYBILL: generate_paybill,
        MessageType.RECEIVE: generate_receive,
        MessageType.SEND: generate_send,
        MessageType.WITHDRAW: generate_withdraw
    }
    
    return (templates[m])()


@click.group()
def devtools():
    pass


@devtools.command()
def send():
    """
    Should send a randomly chosen generated MPESA message to the online VM. 
    
    Usage: Can be used to simulate incoming
    MPESA notification
    """
    message = generate_mpesa_message(choice(list(MessageType)))
    
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