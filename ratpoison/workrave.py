#!/usr/bin/env python

## Control a running workrave via dBus.
## Released under the GNU GPL.
## Joe Milbourn <joe@milbourn.org.uk>, 2008.

from optparse import OptionParser, OptionGroup
import dbus

class Workrave:
	"""
	Possible messages:
	DBusMessage *SetOperationMode(void *object, DBusMessage *message);
	DBusMessage *GetOperationMode(void *object, DBusMessage *message);
	DBusMessage *ReportActivity(void *object, DBusMessage *message);
	DBusMessage *IsTimerRunning(void *object, DBusMessage *message);
	DBusMessage *GetTimerIdle(void *object, DBusMessage *message);
	DBusMessage *GetTimerElapsed(void *object, DBusMessage *message);
	DBusMessage *GetTime(void *object, DBusMessage *message);
	DBusMessage *IsActive(void *object, DBusMessage *message);
	DBusMessage *PostponeBreak(void *object, DBusMessage *message);
	DBusMessage *SkipBreak(void *object, DBusMessage *message);
	"""

	def __init__ (self):
		"Initialise a connection to the workrave dBus"
		bus = dbus.SessionBus()
		obj = bus.get_object("org.workrave.Workrave",
				"/org/workrave/Workrave/Core")
		self.workrave = dbus.Interface(obj, "org.workrave.CoreInterface")
		obj2 = bus.get_object("org.workrave.Workrave", "/org/workrave/Workrave/UI");
		self.workraveMenu = dbus.Interface(obj2, "org.workrave.ControlInterface")

	def getOperatingMode (self):
		"Return a string representing the operating mode"
		return str(self.workrave.GetOperationMode())

	def setOperatingMode (self, mode):
		self.workrave.SetOperationMode(dbus.String(mode))
	
	def reportActivity (self, value=True):
		self.workrave.ReportActivity("workrave-remote", value)

	def isTimerRunning (self, timer):
		"Timer can be one of microbreak, restbreak, or dailylimit"
		return bool(self.workrave.IsTimerRunning(timer))

	def getTimerIdle (self, timer):
		"Timer can be one of microbreak, restbreak, or dailylimit"
		return int(self.workrave.GetTimerIdle(timer))

	def getTimerElapsed (self, timer):
		"Timer can be one of microbreak, restbreak, or dailylimit"
		return int(self.workrave.GetTimerElapsed(timer))

	def getTime (self):
		return int(self.workrave.GetTime())

	def isActive (self):
		return bool(self.workrave.IsActive())

	def postponeBreak (self, timer):
		"Timer can be one of microbreak, restbreak, or dailylimit"
		self.workrave.PostponeBreak(timer)

	def skipBreak (self, timer):
		"Timer can be one of microbreak, restbreak, or dailylimit"
		self.workrave.SkipBreak(timer)

	def takeBreak (self):
		"Start rest break"
		self.workraveMenu.RestBreak()

if __name__ == "__main__":
	parser = OptionParser(
		description= 
"""A dbus interface to a running workrave instance.  Allows getting and
setting of workrave's mode.

Bug reports to Joe Milbourn <joe@milbourn.org.uk> please.""")

	parser.add_option("-m", "--set-mode", dest="set_mode", 
			help="Set workrave mode, possible values normal, quiet, suspended.",
			metavar="MODE")
	parser.add_option("-g", "--get-mode", dest="get_mode",
			help="Get the current mode.", action="store_true")
	parser.add_option("-R", "--report-activity", dest="report",
			help="Send activity notification.", action="store_true")
	parser.add_option("-t", "--time", dest="time",
			help="Return the current time.", action="store_true")
	parser.add_option("-a", "--active", dest="activity",
			help="Return active status.", action="store_true")
	parser.add_option("-b", "--restBreak", action="store_true")

	g = OptionGroup(parser, "Timer specific options",
			"These options all require a TIMER argument which may be any one"
			" of microbreak, restbreak, or dailylimit.")


	g.add_option("-r", "--running", metavar="TIMER",
			help="Is the timer TIMER running.")
	g.add_option("-e", "--elapsed", metavar="TIMER",
			help="Return the elapsed time of TIMER.")
	g.add_option("-i", "--idle", metavar="TIMER",
			help="Return the idle time of TIMER.")

	
	g.add_option("-p", "--postpone", dest="postpone", metavar="TIMER",
			help="Postpone a break for the timer TIMER.")
	g.add_option("-s", "--skip", dest="skip", metavar="TIMER",
			help="Skip a break for the timer TIMER.")

	parser.add_option_group(g)

	(options, args) = parser.parse_args()
	
	w = Workrave()

	if options.set_mode:
		w.setOperatingMode(options.set_mode)

	if options.get_mode:
		print( w.getOperatingMode())
	
	if options.report:
		w.reportActivity()

	if options.time:
		print( w.getTime())

	if options.activity:
		print( w.isActive())

	if options.running:
		print( w.isTimerRunning(options.running))

	if options.elapsed:
		print( w.getTimerElapsed(options.elapsed))

	if options.idle:
		print( w.getTimerIdle(options.idle))

	if options.postpone:
		w.postponeBreak(options.postpone)

	if options.skip:
		w.skipBreak(options.skip)

	if options.restBreak:
		w.takeBreak()
