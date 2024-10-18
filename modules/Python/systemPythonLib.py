#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# IMPORT SECTION
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import mysql.connector
from mysql.connector import Error

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# VIDEO SECTION
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#--------------------------------------------------------------------------------------------------------------------------------
# OBJECT DEFINITIONS
#--------------------------------------------------------------------------------------------------------------------------------
class VideoObject:
    name = ""
    category = ""
#--------------------------------------------------------------------------------------------------------------------------------
# DB INTERFACE
#--------------------------------------------------------------------------------------------------------------------------------
#Opens a connection the the video DB on Alacrisys server
def openAlacrisysVideoDB():
    #Connect to MySQL database
    try:
        connection = mysql.connector.connect(host='52.6.128.97', database='videos', user='root', password='Dragons88.2')
        if connection.is_connected():
            print('Connected to DB')
    except Error as e:
        print(e)
    
    return connection
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# SOFTWARE SECTION
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#--------------------------------------------------------------------------------------------------------------------------------
# OBJECT DEFINITIONS
#--------------------------------------------------------------------------------------------------------------------------------
#Software Object composed of a name and a version specific to that software
class SoftwareObject:
    name = ""
    version = ""

    #Object Constructors, requires a name and a version to create an instance of this object
    #Params:
    # <string>nameIn,
    # <string>versionIn
    def __init__(self, nameIn, versionIn):
        self.name = nameIn
        self.version = versionIn

    def getName(self):
        return str(self.name)
    
    def getVersion(self):
        return str(self.version)
#--------------------------------------------------------------------------------------------------------------------------------
# DB INTERFACE
#--------------------------------------------------------------------------------------------------------------------------------
#Opens a connection the the software DB on Alacrisys server
#Returns: 
# <mysql.connector>connection
def openAlacrisysSoftwareDB():
    #Connect to MySQL database
    try:
        connection = mysql.connector.connect(host='52.6.128.97', database='software-db', user='root', password='Dragons88.2')
        if connection.is_connected():
            print('Connected to DB')
    except Error as e:
        print(e)
    
    return connection

#Closes the connection to Software database
#Params:
# <mysql.connector>dbConIn
def closeAlacrisysSoftwareDB(dbConIn):
    dbConIn.close()

#Returns all the content of the Software DB from the connection
#Params: 
# <mysql.connect>dbConIn
#Returns: 
# <Array of SoftwareObjects>softwareListOut
def getSoftwareList(dbConIn):
    softwareListOut = []
    cursor = dbConIn.cursor()
    query = ("SELECT Name, Version FROM software_list")

    cursor.execute(query)
    results = cursor.fetchall()

    for row in results:
        software = SoftwareObject(row[0], row[1])
        softwareListOut.append(software)

    cursor.close()
    return softwareListOut

#Return the version associated for the specified software name present in the database
#Params: 
# <mysql.connect>dbConIn
# <string>softwareNameIn
#Returns: 
# <string>softwareVersionOut
def getSoftwareVersion(dbConIn, softwareNameIn):
    softwareVersionOut = ""
    cursor = dbConIn.cursor()
    query = ('SELECT version FROM software_list where name="' + softwareNameIn + '"')

    cursor.execute(query)
    results = cursor.fetchall()

    for row in results:
        softwareVersionOut = row[1]
    
    cursor.close()
    return softwareVersionOut

#Compares the local list of programs with the one present in the database and creates an insert query
#from the differences
#Params:
# <mysql.connector>dbConIn,
# <Array of SoftwareObjects>localSoftwareArrayIn,
# <Array of SoftwareObjects>remoteSoftwareArrayIn
#Returns:
# <string>InsertQueryOut
def checkMissingSoftwares(dbConIn, localSoftwareArrayIn, remoteSoftwareArrayIn):
    actualRemote = remoteSoftwareArrayIn
    actualLocal = localSoftwareArrayIn
    missingSoftwares = []
    missingSoftwaresNum = 0
    baseInsertQuery = 'INSERT IGNORE INTO software_list (Name, Version) VALUES'
    insertQueryOut = baseInsertQuery

    for localSoftware in actualLocal:
        softwareMissing = 1
        for remoteSoftware in actualRemote:
            if (localSoftware.name == remoteSoftware.name):
                softwareMissing = 0
        
        if (softwareMissing == 1):
            missingSoftwares.append(localSoftware)
            missingSoftwaresNum += 1

    if(len(missingSoftwares) > 0):
        for software in missingSoftwares:
            insertQueryOut += '("' + software.name + '", "' + software.version + '")'
            if (software.name == "EOF"):
                insertQueryOut += ";"
            else:
                insertQueryOut += ","
    else:
        insertQueryOut = ''    
    
    return insertQueryOut

#Attempts an update of the remote software database based on the differences from the local one
#Params:
# <mysql.connector>dbConIn,
# <Array of SoftwareObjects>softwareArrayIn,
def updateSoftwareList(dbConIn, softwareArrayIn):
    actualRemote = getSoftwareList(dbConIn)
    actualLocal = softwareArrayIn
    cursor = dbConIn.cursor()

    insertQuery = checkMissingSoftwares(dbConIn, actualLocal, actualRemote)

    if (insertQuery != ''):
        print("I'll try to update the database")
        try:
            cursor.execute(insertQuery)
            dbConIn.commit()
        except Error as e:
            print(e)
        finally:
            cursor.close()
    else:
        print("Database is up to date!")
#--------------------------------------------------------------------------------------------------------------------------------
# I/O INTERFACE
#--------------------------------------------------------------------------------------------------------------------------------
#Reads a text file formatted in the way <name>|<version> as a software list
#and creates an internal representation of it for processing
def readSoftwareListFile(pathIn):
    #Opens the file containing the software list and define the needed variables
    softwareFile = open(pathIn, "rb").read()
    softwares = []
    length = 0
    lines = softwareFile.decode('utf-16').splitlines()

    #Runs a for cycle over a range of 250 items to get the max length of the list
    #(This makes the max length inaccurate in case the list is longer than the specified value)
    for line in lines:
        if (line != "") :
            lineSplit = line.split('|')
            if (len(lineSplit) == 2):
                software = SoftwareObject(lineSplit[0], lineSplit[1])
                softwares.append(software)
                length = length + 1

    return softwares
