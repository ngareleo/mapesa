import click 

# Should generate a new MPESA message
def generate_message():
    return "RKT6NKF44A Confirmed. Ksh100.00 paid to DESORA MINIMART. on 29/11/23 at 8:35 AM.New M-PESA balance is Ksh0.00. Transaction cost, Ksh0.00. Amount you can transact within the day is 499,900.00. To move money from bank to M-PESA, dial *334#>Withdraw>From bank to MPESA"


class DeveloperTool: 
    
    def __init__(self):
        pass
    
    
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
    click.echo("❤️ Welcome to the team dev! ❤️")
    
    
if __name__ == "__main__":
    devtools()