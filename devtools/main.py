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
    click.echo("🛎️ sending random message")

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
            auth_code = f.read()

            telnet_connection.write(b"auth " + auth_code.encode("utf-8") + b"\n")
            auth_msg = telnet_connection.read_until(b"OK")

            for i, message in enumerate(mpesa_messages):
                click.echo("[i] : Sending message {} of {}".format(i + 1, len(mpesa_messages)))
                telnet_connection.write(b"sms send MPESA " + message.encode("utf-8"))
                click.echo(telnet_connection.read_until(b"OK").decode("utf-8"))
                click.echo("Send success!")

            telnet_connection.write(b"exit\r\n")
            telnet_connection.write(b"q\r\n")

        telnet_connection.close()
    
    click.echo("\n\n❤️ Welcome to the team dev! ❤️")
    
    
if __name__ == "__main__":
    devtools()