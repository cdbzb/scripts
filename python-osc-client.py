"""
send a single OSC /action message
"""
import argparse
import sys
from pythonosc import osc_message_builder
from pythonosc import udp_client


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("--ip", default="192.168.1.222",
		help="The ip of the OSC server")
	parser.add_argument("--port", type=int, default=8000,
		help="The port the OSC server is listening on")
	args = parser.parse_args()

	client = udp_client.UDPClient(args.ip, args.port)

	action = sys.stdin.read()

	msg = osc_message_builder.OscMessageBuilder(address = "/action")
	msg.add_arg(action)
	msg = msg.build()
	client.send(msg)
