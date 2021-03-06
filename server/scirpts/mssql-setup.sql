-- ----------------------------
--  Table structure for [dbo].[fuel_types]
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[fuel_types]') AND type IN ('U'))
	DROP TABLE [dbo].[fuel_types]
GO
CREATE TABLE [dbo].[fuel_types] (
	[id] varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT [PK__fuel_typ__3213E83F44EC40B9] PRIMARY KEY CLUSTERED ([id]) 
	WITH (IGNORE_DUP_KEY = OFF)
)
GO

-- ----------------------------
--  Table structure for [dbo].[data]
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[data]') AND type IN ('U'))
	DROP TABLE [dbo].[data]
GO
CREATE TABLE [dbo].[data] (
	[id] int NOT NULL,
	[vin] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[param_id] varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[value] float(53) NOT NULL,
	[created] datetime2(0) NOT NULL,
	[updated] datetime2(0) NOT NULL,
	CONSTRAINT [PK__data__3213E83F10F35415] PRIMARY KEY CLUSTERED ([id]) 
	WITH (IGNORE_DUP_KEY = OFF)
)
GO

-- ----------------------------
--  Table structure for [dbo].[parameters]
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('[dbo].[parameters]') AND type IN ('U'))
	DROP TABLE [dbo].[parameters]
GO
CREATE TABLE [dbo].[parameters] (
	[id] varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[units] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[return_bytes] varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] varchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[min_value] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[max_value] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[formula] varchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT [PK__paramete__3213E83FB2FA406F] PRIMARY KEY CLUSTERED ([id]) 
	WITH (IGNORE_DUP_KEY = OFF)
)
GO
CREATE NONCLUSTERED INDEX [name]
ON [dbo].[parameters] ([name] ASC)
WITH (IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	ONLINE = OFF)
GO

-- ----------------------------
--  Records of [dbo].[parameters]
-- ----------------------------
BEGIN TRANSACTION
GO
INSERT INTO [dbo].[parameters] VALUES ('010A', 'O2 Sensor Monitor Bank 3 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('010B', 'O2 Sensor Monitor Bank 3 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('010C', 'O2 Sensor Monitor Bank 3 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('010D', 'O2 Sensor Monitor Bank 4 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('010E', 'O2 Sensor Monitor Bank 4 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('010F', 'O2 Sensor Monitor Bank 4 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('020A', 'O2 Sensor Monitor Bank 3 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('020B', 'O2 Sensor Monitor Bank 3 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('020C', 'O2 Sensor Monitor Bank 3 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('020D', 'O2 Sensor Monitor Bank 4 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('020E', 'O2 Sensor Monitor Bank 4 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('020F', 'O2 Sensor Monitor Bank 4 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('0A', 'Fuel pressure', 'kPa (gauge)', '1', '', '0', '765', 'A*3', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('0B', 'Intake manifold absolute pressure', 'kPa (absolute)', '1', '', '0', '255', 'A', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('0C', 'Engine RPM', 'rpm', '2', '', '0', '16383.75', '((A*256)+B)/4', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('0D', 'Vehicle speed', 'km/h', '1', '', '0', '255', 'A', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('0E', 'Timing advance', '? relative to #1 cylinder', '1', '', '-64', '63.5', 'A/2 - 64', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('0F', 'Intake air temperature', '?C', '1', '', '-40', '215', 'A-40', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('1', 'Monitor status since DTCs cleared. (Includes malfunction indicator lamp (MIL) status and number of DTCs.)', '', '4', '', '', '', 'Test available      Test incompleteMisfire                B0                   B4           Fuel System            B1                   B5Components             B2                   B6Reserved               B3                   B7Catalyst               C0                   D0Heated Catalyst        C1                   D1Evaporative System     C2                   D2Secondary Air System   C3                   D3A/C Refrigerant        C4                   D4Oxygen Sensor          C5                   D5Oxygen Sensor Heater   C6                   D6EGR System             C7                   D7', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('10', 'MAF air flow rate', 'g/s', '2', '', '0', '655.35', '((256*A)+B) / 100', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('100', 'OBD Monitor IDs supported ($01 - $20)', '', '', '', '', '', '', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('101', 'O2 Sensor Monitor Bank 1 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('102', 'O2 Sensor Monitor Bank 1 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('103', 'O2 Sensor Monitor Bank 1 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('104', 'O2 Sensor Monitor Bank 1 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('105', 'O2 Sensor Monitor Bank 2 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('106', 'O2 Sensor Monitor Bank 2 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('107', 'O2 Sensor Monitor Bank 2 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('108', 'O2 Sensor Monitor Bank 2 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('109', 'O2 Sensor Monitor Bank 3 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('11', 'Throttle position', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('110', 'O2 Sensor Monitor Bank 4 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Rich to lean sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('12', 'Commanded secondary air status', '', '1', '', '', '', 'A0     Upstream of catalytic converterA1     Downstream of catalytic converterA2     From the outside atmosphere or offA3-A7  Always zero', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('13', 'Oxygen sensors present', '', '1', '', '', '', '[A0..A3] == Bank 1, Sensors 1-4. [A4..A7] == Bank 2...', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('14', 'Bank 1, Sensor 1:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('15', 'Bank 1, Sensor 2:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('16', 'Bank 1, Sensor 3:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('17', 'Bank 1, Sensor 4:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('18', 'Bank 2, Sensor 1:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('19', 'Bank 2, Sensor 2:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('1A', 'Bank 2, Sensor 3:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('1B', 'Bank 2, Sensor 4:Oxygen sensor voltage,Short term fuel trim', 'Volts%', '2', '', '0-100(lean)', '1.27599.2(rich)', 'A * 0.005(B-128) * 100/128 (if B==0xFF, sensor is not used in trim calc)', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('1C', 'OBD standards this vehicle conforms to', '', '1', '', '', '', '0x01  00000001b    OBD-II as defined by the CARB0x02  00000010b    OBD as defined by the EPA0x03  00000011b    OBD and OBD-II0x04  00000100b    OBD-I0x05  00000101b    Not meant to comply with any OBD standard0x06  00000110b    EOBD (Europe)0x07  00000111b    EOBD and OBD-II0x08  00001000b    EOBD and OBD0x09  00001001b    EOBD, OBD and OBD II0x0A  00001010b    JOBD (Japan)0x0B  00001011b    JOBD and OBD II0x0C  00001100b    JOBD and EOBD0x0D  00001101b    JOBD, EOBD, and OBD II', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('1D', 'Oxygen sensors present', '', '1', '', '', '', 'Similar to PID 13, but [A0..A7] == [B1S1, B1S2, B2S1, B2S2, B3S1, B3S2, B4S1, B4S2]', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('1E', 'Auxiliary input status', '', '1', '', '', '', 'A0 == Power Take Off (PTO) status (1 == active)[A1..A7] not used', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('1F', 'Run time since engine start', 'seconds', '2', '', '0', '65535', '(A*256)+B', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('2', 'Freeze frame trouble code', '', '2', '', '', '', '', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('20', 'PIDs supported 21-40', '', '4', '', '', '', 'Bit encoded [A7..D0] == [PID 0x21..PID 0x40]', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('201', 'O2 Sensor Monitor Bank 1 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('202', 'O2 Sensor Monitor Bank 1 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('203', 'O2 Sensor Monitor Bank 1 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('204', 'O2 Sensor Monitor Bank 1 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('205', 'O2 Sensor Monitor Bank 2 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('206', 'O2 Sensor Monitor Bank 2 Sensor 2', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('207', 'O2 Sensor Monitor Bank 2 Sensor 3', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('208', 'O2 Sensor Monitor Bank 2 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('209', 'O2 Sensor Monitor Bank 3 Sensor 1', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('21', 'Distance traveled with malfunction indicator lamp (MIL) on', 'km', '2', '', '0', '65535', '(A*256)+B', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('210', 'O2 Sensor Monitor Bank 4 Sensor 4', 'Volts', '', '', '0', '1.275', '0.005 Lean to Rich sensor threshold voltage', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('22', 'Fuel Rail Pressure (relative to manifold vacuum)', 'kPa', '2', '', '0', '5177.265', '((A*256)+B) * 0.079', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('23', 'Fuel Rail Pressure (diesel)', 'kPa (gauge)', '2', '', '0', '655350', '((A*256)+B) * 10', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('24', 'O2S1_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('25', 'O2S2_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('26', 'O2S3_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('27', 'O2S4_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('28', 'O2S5_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('29', 'O2S6_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('2A', 'O2S7_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('2B', 'O2S8_WR_lambda(1):Equivalence RatioVoltage', 'N/AV', '4', '', '00', '28', '((A*256)+B)*0.0000305((C*256)+D)*0.000122', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('2C', 'Commanded EGR', '?%', '1', '', '0', '100', '100*A/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('2D', 'EGR Error', '?%', '1', '', '-100', '99.22', 'A*0.78125 - 100', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('2E', 'Commanded evaporative purge', '?%', '1', '', '0', '100', '100*A/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('2F', 'Fuel Level Input', '?%', '1', '', '0', '100', '100*A/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('3', 'Fuel system status', '', '2', '', '', '', 'A0     Open loop due to insufficient engine temperatureA1     Closed loop, using oxygen sensor feedback to determine fuel mixA2     Open loop due to engine load OR fuel cut due to desacceleration A3     Open loop due to system failureA4     Closed loop, using at least one oxygen sensor but there is a fault in the feedback systemA5-A7  Always zero', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('30', '# of warm-ups since codes cleared', 'N/A', '1', '', '0', '255', 'A', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('31', 'Distance traveled since codes cleared', 'km', '2', '', '0', '65535', '(A*256)+B', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('32', 'Evap. System Vapor Pressure', 'Pa', '2', '', '-8192', '8192', '((A*256)+B)/4 - 8,192', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('33', 'Barometric pressure', 'kPa (Absolute)', '1', '', '0', '255', 'A', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('34', 'O2S1_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('35', 'O2S2_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('36', 'O2S3_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('37', 'O2S4_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('38', 'O2S5_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('39', 'O2S6_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('3A', 'O2S7_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('3B', 'O2S8_WR_lambda(1):Equivalence RatioCurrent', 'N/AmA', '4', '', '0-128', '2128', '((A*256)+B)*0.0000305((C*256)+D)*0.00390625 - 128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('3C', 'Catalyst TemperatureBank 1, Sensor 1', '?C', '2', '', '-40', '6513.5', '((A*256)+B)/10 - 40', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('3D', 'Catalyst TemperatureBank 2, Sensor 1', '?C', '2', '', '-40', '6513.5', '((A*256)+B)/10 - 40', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('3E', 'Catalyst TemperatureBank 1, Sensor 2', '?C', '2', '', '-40', '6513.5', '((A*256)+B)/10 - 40', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('3F', 'Catalyst TemperatureBank 2, Sensor 2', '?C', '2', '', '-40', '6513.5', '((A*256)+B)/10 - 40', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('4', 'Calculated engine load value', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('40', 'PIDs supported 41-60', '', '4', '', '', '', 'Bit encoded [A7..D0] == [PID 0x41..PID 0x60]', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('41', 'Monitor status this drive cycle', '', '4', '', '', '', 'Test enabled       Test incompleteMisfire                B0                   B4           Fuel System            B1                   B5Components             B2                   B6Reserved               B3                   B7Catalyst               C0                   D0Heated Catalyst        C1                   D1Evaporative System     C2                   D2Secondary Air System   C3                   D3A/C Refrigerant        C4                   D4Oxygen Sensor          C5                   D5Oxygen Sensor Heater   C6                   D6EGR System             C7                   D7', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('42', 'Control module voltage', 'V', '2', '', '0', '65.535', '((A*256)+B)/1000', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('43', 'Absolute load value', '?%', '2', '', '0', '25700', '((A*256)+B)*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('44', 'Command equivalence ratio', 'N/A', '2', '', '0', '2', '((A*256)+B)*0.0000305', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('45', 'Relative throttle position', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('46', 'Ambient air temperature', '?C', '1', '', '-40', '215', 'A-40', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('47', 'Absolute throttle position B', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('48', 'Absolute throttle position C', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('49', 'Accelerator pedal position D', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('4A', 'Accelerator pedal position E', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('4B', 'Accelerator pedal position F', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('4C', 'Commanded throttle actuator', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('4D', 'Time run with MIL on', 'minutes', '2', '', '0', '65535', '(A*256)+B', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('4E', 'Time since trouble codes cleared', 'minutes', '2', '', '0', '65535', '(A*256)+B', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('5', 'Engine coolant temperature', '?C', '1', '', '-40', '215', 'A-40', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('51', 'Fuel Type', '', '1', '', '', '', '01    Gasoline02    Methanol03    Ethanol04    Diesel05    LPG06    CNG07    Propane08    Electric09    Bifuel running Gasoline0A    Bifuel running Methanol0B    Bifuel running Ethanol0C    Bifuel running LPG0D    Bifuel running CNG0E    Bifuel running Prop0F    Bifuel running Electricity10    Bifuel mixed gas/electric11    Hybrid gasoline12    Hybrid Ethanol13    Hybrid Diesel14    Hybrid Electric15    Hybrid Mixed fuel16    Hybrid Regenerative', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('52', 'Ethanol fuel?%', '?%', '1', '', '0', '100', 'A*100/255', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('6', 'Short term fuel?% trim?Bank 1', '?%', '1', '', '-100 (Rich)', '99.22 (Lean)', '(A-128) * 100/128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('7', 'Long term fuel?% trim?Bank 1', '?%', '1', '', '-100 (Rich)', '99.22 (Lean)', '(A-128) * 100/128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('8', 'Short term fuel?% trim?Bank 2', '?%', '1', '', '-100 (Rich)', '99.22 (Lean)', '(A-128) * 100/128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('9', 'Long term fuel?% trim?Bank 2', '?%', '1', '', '-100 (Rich)', '99.22 (Lean)', '(A-128) * 100/128', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('AX', 'Acceleration - X', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('AY', 'Acceleration - Y', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('AZ', 'Acceleration - Z', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('C3', '??', '??', '??', '', '??', '??', 'Returns numerous data, including Drive Condition ID and Engine Speed*', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('C4', '??', '??', '??', '', '??', '??', 'B5 is Engine Idle RequestB6 is Engine Stop Request*', 'OBD-II');
INSERT INTO [dbo].[parameters] VALUES ('CO', 'GPS Course', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('HA', 'GPS Horizontal Accuracy', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('LA', 'GPS Latitude', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('LO', 'GPS Longitude', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('SP', 'GPS Speed', null, null, null, null, null, null, 'Sensor');
INSERT INTO [dbo].[parameters] VALUES ('VA', 'GPS Vertical Accuracy', null, null, null, null, null, null, 'Sensor');
GO
COMMIT
GO

