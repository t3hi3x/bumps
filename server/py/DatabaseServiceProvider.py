import string
import datetime

from java.lang import *
from java.sql import *

class DatabaseServiceProvider():
	def __init__(self, connection_string, driver, debug):
		self.connection_string = connection_string
		self.driver = driver
		self.debug = debug
		
		Class.forName(self.driver)
		self.conn = DriverManager.getConnection(self.connection_string)

		self.decode = {"00": self.supported,
					   "04": self.engineLoad,
					   "05": self.coolantTemp,
					   "0A": self.fuelPressure,
					   "0C": self.rpm,
					   "0D": self.mph,
					   "11": self.throttle,
					   "AX": self.accelerometer,
					   "AY": self.accelerometer,
					   "AZ": self.accelerometer,
					   "LA": self.gpsCoordinate,
					   "LO": self.gpsCoordinate,
					   "CO": self.gpsData,
					   "HA": self.gpsData,
					   "VA": self.gpsData,
					   "SP": self.gpsData,
		}

	def supported(self, bytes):
		return None

	def executeSQL(self, query, insert=False):
		""" Runs a Query via JDBC and returns a Java result set	"""
		stmt = self.conn.createStatement()
		if not insert:
			result = stmt.executeQuery(query)
		else:
			result = stmt.executeUpdate(query)
		return result

	def engineLoad(self, bytes): #unit: percent, 0-100
		x = int(bytes, 16)
		if x > 255:
			print "Error! PID:04 - one byte only"
			return None
		return x * 100.0 / 255.0

	def coolantTemp(self, bytes): #unit: degC, -40-215
		x = int(bytes, 16)
		if x > 255:
			print "Error! PID:05 - one byte only"
			return None
		return x - 40

	def fuelPressure(self, bytes): #unit: kPa, 0-765
		x = int(bytes, 16)
		if x > 255:
			print "Error! PID:0A - one byte only"
			return None
		return x * 3

	def rpm(self, bytes): #unit rpm, 0-16383.75
		x = int(bytes, 16)
		if x > 65535:
			print "Error! PID:0C - two bytes only"
			return None
		return x / 4.0

	def mph(self, bytes): #unit mph, 0-158.4
		x = int(bytes, 16)
		if x > 255:
			print "Error! PID:0D - one byte only"
			return None
		return x * 0.621

	def throttle(self, bytes): #unit: percent, 0-100
		x = int(bytes, 16)
		if x > 255:
			print "Error! PID:11 - one byte only"
			return None
		return x * 100.0 / 255.0

	def accelerometer(self, bytes):
		return bytes

	def gpsCoordinate(self, bytes):
		return bytes

	def gpsData(self, bytes):
		return bytes

	def decodePIDValue(self, pid, bytes):
		try:
			value = self.decode[string.upper(pid)](bytes)
		except KeyError:
			print "PID:%s not supported..." % pid
			return None
		return value

	def logToDatabase(self, data):
		isInt, isFloat = True, True
		data = data.split(':')
		if len(data) is not 4:
			print "Bad data: %s" % data
			return
		try:
			float(data[2])
		except ValueError:
			isFloat = False
		try:
			int(data[2], 16)
		except:
			isInt = False
		if not isInt and not isFloat:
			print "Bad data: %s" % data
			return
		value = self.decodePIDValue(data[1], data[2])
		date = datetime.datetime.fromtimestamp(float(data[3]))
		if value is not None:
			if self.debug:
				print "PID: %s, add %s to db for VIN:%s" % (data[1], value, data[0])
			self.insert(data[0],data[1],value, date)
		else:
			print "Error decoding PID, fail!"

	def insert(self, vin, pid, data, date):
		query = """
				insert into data (vin, param_id, value, created) values('%s','%s','%s','%s')
				""" % (vin, pid, data, date)
		self.executeSQL(query, insert=True)

