#!../../bin/linux-x86_64/Keithley24002

## You may have to change Keithley24002 to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/Keithley24002.dbd"
Keithley24002_registerRecordDeviceDriver pdbbase


asynSetAutoConnectTimeout(1.0)
drvAsynIPPortConfigure( "SOURC1", "10.112.8.71:4001 tcp", 0, 0, 0 )
drvAsynIPPortConfigure( "SOURC2", "10.112.8.71:4002 tcp", 0, 0, 0 )
epicsEnvSet "STREAM_PROTOCOL_PATH", "$(KEITHLEY)/protocol"


#enables debugging 0xff is the max setting
#asynSetTraceIOMask("SOURC1", 0,0x1)
#asynSetTraceMask("SOURC1", 0,0x8)


#asynSetTraceIOMask("SOURC2", 0,0x1)
#asynSetTraceMask("SOURC2", 0,0x8)



## Load record instances
dbLoadRecords("db/keithley24002.db")

######################################################
#Autosave
epicsEnvSet("IOCNAME","bl4a-Keithley24002")
epicsEnvSet("SAVE_DIR","/home/controls/var/$(IOCNAME)")

save_restoreSet_Debug(0)

### status-PV prefix, so save_restore can find its status PV's.
save_restoreSet_status_prefix("BL4A:SM1:")

set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass0_restoreFile("$(IOCNAME).sav")
############################################################


cd "${TOP}/iocBoot/${IOC}"
iocInit





## Start any sequence programs
#seq sncxxx,"user=zmaHost"


epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
create_monitor_set("$(IOCNAME).req", 5)



