## Configuring the HP C7000 Chassis via command line. 
Connect to the Active OA module via SSH from your laptop using a terminal utility. Use the credentials - Administrator and the factory password to log in. The configuration needs to be performed only on the Active OA module, and they will automatically migrate to the standby module.

###Setting Enclosure Name and Hostname and OA1 and OA2 IP addresses
```
SET ENCLOSURE NAME "HPc7k"
SET RACK NAME "C7k"
SET OA NAME 1 HPC7-01
SET IPCONFIG STATIC 1 10.216.192.233 255.255.255.0 10.216.192.1 0.0.0.0 0.0.0.0
SET NIC AUTO 1
SET OA NAME 2 HPC7-02
SET IPCONFIG STATIC 2 10.216.192.232 255.255.255.0 10.216.192.1 0.0.0.0 0.0.0.0
SET NIC AUTO 2
```
Note that if you change the IP addresses of the OA here, you may lose connectivity and need to re-connect after this step.

###Setting Timezone, NTP and SNMP
```
SET TIMEZONE UTC
SET NTP PRIMARY 10.192.70.1
SET NTP SECONDARY 0.0.0.0
SET NTP POLL 720
ENABLE NTP
SET SNMP CONTACT "talktome@company.com"
SET SNMP LOCATION "Disneyland"
SET SNMP COMMUNITY READ "s3cr3t"
SET SNMP COMMUNITY WRITE "s3cr3t"
ADD SNMP TRAPRECEIVER 10.194.236.20
ADD SNMP TRAPRECEIVER 10.194.102.26
ENABLE SNMP
```

###Enable/disable configuration mechanisms
```
ENABLE WEB
ENABLE SECURESH
DISABLE TELNET
ENABLE XMLREPLY
ENABLE GUI_LOGIN_DETAIL
ENABLE ACTIVE_HEALTH_SYSTEM
SET ENCRYPTION NORMAL
```

###Setup Power management
```
SET POWER MODE REDUNDANT
SET POWER SAVINGS ON
```


###Configure Enclosure Bays
```
SET EBIPA SERVER <IP ADDRESS> <NETMASK> <BAY#> 
SET EBIPA SERVER GATEWAY <DEFAULT GATEWAY> <BAY#>
SET EBIPA SERVER DOMAIN <DOMAIN> <BAY#>
ENABLE EBIPA SERVER <BAY#>
```

Run the above commands for as many blades there may be in the chassis

###Configure Interconnect Bays
```
SET EBIPA INTERCONNECT <IPADDRESS> <NETMASK> <BAY#>
SET EBIPA INTERCONNECT GATEWAY <DEFAULT GATEWAY> <BAY#>
SET EBIPA INTERCONNECT DOMAIN <DOMAIN> <BAY#>
SET EBIPA INTERCONNECT NTP PRIMARY <IP ADDRESS> <BAY#>
SET EBIPA INTERCONNECT NTP SECONDARY <IP ADDRESS> <BAY#>
ENABLE EBIPA INTERCONNECT <BAY#>
```

###Adding users
```
ADD USER "Administrator"
SET USER CONTACT "Administrator" ""
SET USER FULLNAME "Administrator" "System Administrator"
SET USER ACCESS "Administrator" ADMINISTRATOR
ASSIGN SERVER 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,1A,2A,3A,4A,5A,6A,7A,8A,9A,10A,11A,12A,13A,14A,15A,16A,1B,2B,3B,4B,5B,6B,7B,8B,9B,10B,11B,12B,13B,14B,15B,16B "Administrator"
ASSIGN INTERCONNECT 1,2,3,4,5,6,7,8 "Administrator"
ASSIGN OA "Administrator"
ENABLE USER "Administrator"
```
