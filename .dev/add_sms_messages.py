from telnetlib import Telnet

with Telnet("localhost", 5554) as teln_conn:
    connect_msg = teln_conn.read_until(b"OK").decode("utf-8")
    print(connect_msg)
    auth_file_fs = connect_msg.split("\n")[3].strip()[1:-1]
    with open(auth_file_fs, "r") as f:
        auth_code = f.read()

        teln_conn.write(b"auth " + auth_code.encode("utf-8") + b"\n")
        auth_msg = teln_conn.read_until(b"OK")

        print(auth_msg.decode("utf-8"))
