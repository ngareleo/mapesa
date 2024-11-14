import click 
from telnetlib import Telnet
from generate import MessageGenerator, FsHandler, MessageType
from random import choice

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
    
    **Usage**
    
    Can be used to simulate incoming MPESA notification. 
    """
    
    telnet = Telnet("localhost", 5554)
    
    # spit back to stdout
    connect_msg = telnet.read_until(b"OK").decode("utf-8")
    click.echo(connect_msg)
    
    auth_file_fs = connect_msg.split("\n")[3].strip()[1:-1]
    with FsHandler() as fs, MessageGenerator(fs=fs) as gen, open(auth_file_fs, "r") as f:
        message = gen.new(choice(list(MessageType)))
        
        # auth into the vm
        auth_code = f.read()
        telnet.write(b"auth " + auth_code.encode("utf-8") + b"\n")            
        
        # send message
        telnet.write(b"sms send MPESA " + message.encode("utf-8"))

        # write back into stdout 
        click.echo(telnet.read_until(b"OK").decode("utf-8"))
        
        # quit telnet
        telnet.write(b"exit\r\n")
        telnet.write(b"q\r\n")
        
    telnet.close()

    

@devtools.command()
def init():
    """
    Flood VM with MPESA messages. 

    **Usage** 
    
    To onboard messages onto a VM
    """

    with FsHandler() as fs, Telnet("localhost", 5554) as telnet:
        
        size = len(fs.messages)
        
        # spit back to stdout
        connect_msg = telnet.read_until(b"OK").decode("utf-8")
        click.echo(connect_msg)
        
        auth_file_fs = connect_msg.split("\n")[3].strip()[1:-1]
        with open(auth_file_fs, "r") as f:
            # auth into the vm
            auth_code = f.read()
            telnet.write(b"auth " + auth_code.encode("utf-8") + b"\n")

            # write all the messages into the VM
            for i, message in enumerate(fs.messages):
                click.echo("[i] : Sending message {} of {}".format(i + 1, size))
                telnet.write(b"sms send MPESA " + message.encode("utf-8"))
                click.echo(telnet.read_until(b"OK").decode("utf-8"))
                click.echo("Send success!")

            # quit telnet
            telnet.write(b"exit\r\n")
            telnet.write(b"q\r\n")
    
    telnet.close()
    click.echo("\n\n❤️ Welcome to the team dev! ❤️")
    
    
if __name__ == "__main__":
    devtools()