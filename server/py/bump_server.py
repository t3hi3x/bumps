import SocketServer
import threading
import DatabaseServiceProvider
import ConfigParser

class ThreadedTCPRequestHandler(SocketServer.StreamRequestHandler):
	def handle(self):
		resp = True
		driver = config.get("database", "jdbc_driver")
		connection_string = config.get("database", "connection_string")
		db_handler = DatabaseServiceProvider.DatabaseServiceProvider(connection_string, driver)
		while resp:
			resp = self.rfile.readline().strip()
			self.data = resp
			data = resp
			cur_thread = threading.currentThread()
			response = "%s: %s" % (cur_thread.getName(), data)
			print response
			if data:
				db_handler.logToDatabase(data)
			self.request.send("OK")

class ThreadedTCPServer(SocketServer.ThreadingMixIn, SocketServer.TCPServer):
	pass

if __name__== "__main__":
	config = ConfigParser.ConfigParser()
	config.read("config.conf")

	BIND_ADDRESS = config.get("bumps", "bind_address")
	if not BIND_ADDRESS:
		BIND_ADDRESS = ""
	PORT = int(config.get("bumps", "port"))
	server = ThreadedTCPServer((BIND_ADDRESS, PORT), ThreadedTCPRequestHandler)
	server_thread = threading.Thread(target=server.serve_forever)
	server_thread.setDaemon(True)
	server_thread.start()
	server_thread.getName()
	print "Server started..."
	while True:
		pass