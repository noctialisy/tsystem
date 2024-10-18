@ECHO OFF &COLOR 70 &TITLE Windows 10 default services, script by AveYo &echo/ 
SET QUIT=PING -n 10 0 ^>NUL 2^>^&1 ^&COLOR 70 ^&EXIT/B
:: check win version
FOR /F "tokens=4-5 delims=. " %%i IN ('ver') DO SET "WINVER=%%i%%j"
IF %WINVER% LSS 100 COLOR 74 &echo ERROR! ONLY FOR WINDOWS 10 &%QUIT%
:: check for admin rights
SET "ADM=" &bcdedit >NUL 2>&1
IF NOT "%ERRORLEVEL%"=="1" SET "ADM=Y"
IF NOT DEFINED ADM COLOR 74 &echo  ERROR! Run again by right-clicking and selecting 'Run as administrator' &%QUIT%
:: gives time to cancel before any changes (all scripts should provide this...)
FOR /L %%I IN (10,-1,1) DO CLS &echo. &echo  Starting in %%Is. Press [Ctrl+C] or X corner to cancel... &PING -n 2 0 >NUL 2>&1
CLS &echo/

SET "services_auto= AudioEndpointBuilder Audiosrv BFE BrokerInfrastructure CoreMessagingRegistrar CryptSvc DcomLaunch Dhcp DiagTrack Dnscache DPS EventLog EventSystem FontCache gpsvc iphlpsvc LanmanServer LanmanWorkstation LSM MpsSvc NlaSvc nsi Power ProfSvc RpcEptMapper RpcSs SamSs Schedule SENS ShellHWDetection Spooler SysMain SystemEventsBroker Themes tiledatamodelsvc TrkWks UserManager Wcmsvc Winmgmt WinRM " 
SET "services_delayed_auto= BITS DoSvc dmwappushsvc MapsBroker sppsvc wscsvc WSearch"
SET "services_demand= AJRouter ALG AppIDSvc Appinfo AppMgmt AppReadiness AppXSvc AxInstSV BDESVC Browser BthHFSrv bthserv CDPSvc CertPropSvc ClipSVC COMSysApp CscService DcpSvc defragsvc DeviceAssociationService DeviceInstall DevQueryBroker diagnosticshub.standardcollector.service DmEnrollmentSvc dot3svc DsmSvc DsSvc Eaphost EFS embeddedmode EntAppSvc Fax fdPHost FDResPub fhsvc hidserv HomeGroupListener HomeGroupProvider icssvc IEEtwCollectorService Ifsvc IKEEXT KeyIso KtmRm LicenseManager lltdsvc lmhosts MSDTC MSiSCSI msiserver NcaSvc NcbService NcdAutoSetup Netlogon Netman netprofm NetSetupSvc NgcCtnrSvc NgcSvc nvsvc p2pimsvc p2psvc PcaSvc PeerDistSvc PerfHost pla PlugPlay PNRPAutoReg PNRPsvc PolicyAgent PrintNotify QWAVE RasAuto RasMan RetailDemo RpcLocator ScDeviceEnum SCPolicySvc SDRSVC seclogon SensorDataService SensorService SensrSvc SessionEnv SharedAccess smphost SmsRouter SNMPTRAP SSDPSRV SstpSvc StateRepository stisvc StorSvc svsvc swprv TabletInputService TapiSrv TermService TimeBroker TrustedInstaller UI0Detect UmRdpService upnphost UsoSvc VaultSvc vds vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss VSS W32Time WalletService wbengine WbioSrvc wcncsvc WcsPlugInService WdiServiceHost WdiSystemHost WdNisSvc WebClient Wecsvc WEPHOSTSVC wercplsupport WerSvc WiaRpc WinDefend WinHttpAutoProxySvc WlanSvc wlidsvc wmiApSrv WMPNetworkSvc workfolderssvc WPDBusEnum WpnService WSService wuauserv wudfsvc WwanSvc XblAuthManager XblGameSave XboxNetApiSvc "
SET "services_disabled= NetTcpPortSharing RemoteAccess RemoteRegistry SCardSvr "
FOR %%A IN (%services_auto%) DO <NUL SET /P=%%A &sc config %%A start= auto
FOR %%A IN (%services_delayed_auto%) DO <NUL SET /P=%%A &sc config %%A start= delayed-auto
FOR %%A IN (%services_demand%) DO <NUL SET /P=%%A &sc config %%A start= demand
FOR %%A IN (%services_disabled%) DO <NUL SET /P=%%A &sc config %%A start= disabled

GOTO :_DONE_
rem comment above line to also reset default device drivers

SET "drivers_auto= lltdio luafv MMCSS mrxsmb10 MsLldp Ndu PEAUTH rspndr srv storqosflt tcpipreg "
SET "drivers_boot= ACPI acpiex atapi CLFS CNG disk EhStorClass FileInfo FltMgr fvevol hwpolicy intelide KSecDD KSecPkg mountmgr msisadrv Mup NDIS partmgr pci pcw pdc rdyboost spaceport Tcpip vdrvroot volmgr volmgrx volsnap Wdf01000 WFPLWFS WindowsTrustedRT WindowsTrustedRTProxy Wof "
SET "drivers_demand= 1394ohci 3ware acpipagr AcpiPmi acpitime ADP80XX agp440 AmdK8 AmdPPM amdsata amdsbs amdxata AppID arcsas AsyncMac b06bdrv bcmfn2 bowser BthAvrcpTg BthHFEnum bthhfhid BTHMODEM buttonconverter CapImg circlass CmBatt CompositeBus condrv dmvsc drmkaud DXGKrnl ebdrv EhStorTcgDrv ErrDev exfat fastfat fcvsc fdc Filetrace flpydisk FsDepends gagp30kx gencounter genericusbfn GPIOClx0101 HdAudAddService HDAudBus HidBatt HidBth hidi2c hidinterrupt HidIr HidUsb HpSAMD HTTP hyperkbd HyperVideo i8042prt iaLPSSi_GPIO iaLPSSi_I2C iaStorAV iaStorV ibbus IntcAzAudAddService intelpep intelppm IoQos IpFilterDriver IPMIDRV IPNAT IRENUM isapnp iScsiPrt kbdclass kbdhid kdnic ksthunk L1C LSI_SAS LSI_SAS2i LSI_SAS3i LSI_SSS lvpepf64 LVRS64 LVUSBS64 megasas megasr mlx4_bus Modem monitor mouclass mouhid mpsdrv MRxDAV mrxsmb mrxsmb20 MsBridge msgpiowin32 mshidkmdf mshidumdf MSKSSRV MSPCLOCK MSPQM MsRPC MSTEE MTConfig MTsensor mvumis NativeWifiP ndfltr NdisCap NdisImPlatform NdisTapi Ndisuio NdisVirtualBus NdisWan ndiswanlegacy ndproxy netvsc NTFS nvlddmkm nvraid nvstor nv_agp Parport pciide pcmcia percsas2i percsas3i PID_PEPI PptpMiniport Processor QWAVEdrv RasAcd RasAgileVpn Rasl2tp RasPppoe RasSstp rdpbus RDPDR RdpVideoMiniport ReFSv1 rspLLL s3cap sbp2port scfilter sdbus sdstor SerCx SerCx2 Serenum Serial sermouse sfloppy SiSRaid2 SiSRaid4 SpbCx srv2 srvnet stexstor storahci storflt stornvme storufs storvsc swenum Synth3dVsc Tcpip6 terminpt TPM TsUsbFlt TsUsbGD tunnel uagp35 UASPStor UcmCx0101 UcmUcsi Ucx01000 UdeCx UEFI Ufx01000 UfxChipidea ufxsynopsys uliagpkx umbus UmPass UrsChipidea UrsCx01000 UrsSynopsys usbaudio usbccgp usbcir usbehci usbhub USBHUB3 usbohci usbprint usbser USBSTOR usbuhci USBXHCI VerifierExt vhdmp vhf vmbus VMBusHID vpci vsmraid VSTXRAID vwifibus WacomPen wanarp wanarpv6 WdBoot WdFilter wdiwifi WdNisDrv wfpcapture WIMMount WinMad WINUSB WinVerbs WmiAcpi wpcfltr WpdUpFltr WudfPf WUDFRd xboxgip xinputhid "
SET "drivers_disabled= cdfs cnghwassist udfs ws2ifsl "
SET "drivers_system= AFD ahcache avipbb avkmgr BasicDisplay BasicRender Beep cdrom CSC dam Dfsc FileCrypt GpuEnergyDrv Msfs mssmbios NetBIOS NetBT Npfs npsvctrig nsiproxy Null Psched rdbss tdx vwififlt "
FOR %%A IN (%drivers_auto%) DO <NUL SET /P=%%A &sc config %%A start= auto
FOR %%A IN (%drivers_boot%) DO <NUL SET /P=%%A &sc config %%A start= boot
FOR %%A IN (%drivers_demand%) DO <NUL SET /P=%%A &sc config %%A start= demand
FOR %%A IN (%drivers_disabled%) DO <NUL SET /P=%%A &sc config %%A start= disabled
FOR %%A IN (%drivers_system%) DO <NUL SET /P=%%A &sc config %%A start= system

GOTO :_DONE_ 
:_DONE_
echo/ &echo Done, reboot your PC now... &%QUIT%