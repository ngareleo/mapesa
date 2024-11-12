from telnetlib import Telnet
import os


with Telnet("localhost", 5554) as telnet_connection:
    connect_msg = telnet_connection.read_until(b"OK").decode("utf-8")
    print(connect_msg)
    auth_file_fs = connect_msg.split("\n")[3].strip()[1:-1]
    with open(auth_file_fs, "r") as f:
        auth_code = f.read()
        
        telnet_connection.write(b"auth " + auth_code.encode("utf-8") + b"\n")
        auth_msg = telnet_connection.read_until(b"OK")

        messages = open(
            os.path.join(os.path.dirname(os.path.abspath(__file__)), "sample_sms.txt"),
            "r",
        ).readlines()

        for i, message in enumerate(messages):
            print("[i] : Sending message {} of {}".format(i + 1, len(messages)))
            telnet_connection.write(b"sms send MPESA " + message.encode("utf-8"))
            print(telnet_connection.read_until(b"OK").decode("utf-8"))
            print("Send success!")

        telnet_connection.write(b"exit\r\n")
        telnet_connection.write(b"q\r\n")

    telnet_connection.close()
