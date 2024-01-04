from telnetlib import Telnet

with Telnet("localhost", 5554) as tn:
    connect_msg = tn.read_until(b"OK").decode("utf-8")
    print(connect_msg)
    fs = connect_msg.split("\n")[3].strip()[1:-1]
    with open(fs, "r") as f:
        auth_code = f.read()

        tn.write(b"auth " + auth_code.encode("utf-8") + b"\n")
        auth_msg = tn.read_until(b"OK")
        print(auth_msg.decode("utf-8"))



