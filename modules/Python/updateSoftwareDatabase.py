#Imports the local library file
import mysql.connector
import systemPythonLib
import sys
from mysql.connector import Error

softwareConnection = systemPythonLib.openAlacrisysSoftwareDB()
softwares = systemPythonLib.readSoftwareListFile(sys.argv[1])
systemPythonLib.updateSoftwareList(softwareConnection, softwares)