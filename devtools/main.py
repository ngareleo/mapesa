import click 
from telnetlib import Telnet
import os

mpesa_messages = open(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "sample_sms.txt"),
    "r",
).readlines()

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

        telnet_connection.close()
    
    click.echo("\n\n❤️ Welcome to the team dev! ❤️")

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

        telnet_connection.close()
    
    click.echo("\n\n❤️ Welcome to the team dev! ❤️")
    
    
if __name__ == "__main__":
    devtools()