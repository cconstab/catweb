# CATWEB

## Project Aim

 To provide near real-time frequency and modulation mode being used to a website, so other operators know where you are listening.
  No firewall ports should need to be opened, all data across Internet should be encrypted.
  An example site can be seen here [AI6BH](https://wavi.ng/@AI6BH). If I am not listening you will not see the listening sections as the entries time out after an hour of no activity.
## Issues
If you hit any issues with the application then please just rasie and issue ticket [here](https://github.com/cconstab/catweb/issues) with as much detail as possible.

![image](https://user-images.githubusercontent.com/6131216/143327480-275d1d74-9e31-40f9-92e6-85d7f4202304.png)

Screenshot of IC-7100 and the website showing listening at 7.185Mhz LSB

![IMG_20210903_142218](https://user-images.githubusercontent.com/6131216/132066553-28544268-82c9-4ed9-ac91-151c71cc1070.jpg)


## Full Disclosure
I am part of the founding team of the wavi.ng website and the opensoure project that provides the underlying technology.
- [@Foundation](https://github.com/atsign-foundation) Open Source Project
- [@Platform](https://atsign.dev) Documentation for developers
- [@Company](https://atsign.com) Get an @sign (free or paid)

  
## How this is implemented

TLDR;
 This appication connects to your HamRadio's CAT port via `rigctld` and publishes the Frequency and Modulation mode to your [@wavi](https://wavi.ng) page. Both this app and @wavi require you to have an @sign, which is a new Internet identity which you can own and allow others access to your data. If you would like your Callsign as your @sign then visit [atsign.com](https://atsign.com) to buy it or see if there are any offers for Hams (I am working on it for you!)

 ## More details  

 The [hamlib project](https://github.com/Hamlib/Hamlib) is truly awesome and allows most rigs to be connected and controlled remotely or locally via the CAT interface that is found on most modern Ham radio rigs.

 This project builds on the hamlib and inparticular the use of `rigctld` which exposes the rigctl via TCP socket. Rigctld can run on Windows or you can use as I do a Raspberry PI. Once you have rigctld running then you can use this application to connect to it. Add a radio then input the IP address of the machine running rigctld and the port number you selected. For example, this is what I run on my PI.

 `rigctld -m 370 -r /dev/ttyUSB2 -t 7100 -s 19200 -v`  

 This connects to my IC-7100 via the USB CAT on /dev/ttyUSB2 and then listens on port 7100. The 19200 and the -v are not strictly required but nice to see the traffic to the radio.  

 Once rigctld is running run this application and add a radio, you will be asked for a name, IP and port number.

 ![image](https://user-images.githubusercontent.com/6131216/143328733-ec708e3a-288a-4204-a642-fab60b2ff544.png)

 This application connects the TCP socket and then publishes the information publically via your @sign. A web application called cateyes then can read that information and display it on a webpage. This application also updates your @wavi page with an iFrame containing the cateyes web application.

 
 
 
![image](https://user-images.githubusercontent.com/6131216/143367551-74d669c7-57ed-4737-b192-d35e89a2b3d7.png)

 ## Installation
### Hamlib installation and connection to rig
 First step is to connect your rig to the computer you plan to run the [hamlib project](https://github.com/Hamlib/Hamlib) tools. In my case that was as simple as a RaspberryPI and a USB Cable connected to my Icom IC-7100. It is also completely fine to use a Windows machine or a Mac (Google Hamlib mac).
 On a modern Linux system you can either download the binaries from the hamlib project, compile them from the source code or even easier add them using the package manager on your Linux distro.
 
 On the RaspberryPi this was simply a matter of using the following commmad.
 ```
 sudo apt install libhamlib-utils
 ```

 If you have an older radio you might have to connect via USB to serial connection or perhaps just a serial connector. Whatever the case you will be able to run `rigctl` to test the connection is working as it should.

```
pi@serverlan:~ $ ls -l /dev/ttyUSB*
crw-rw---- 1 root dialout 188, 0 Sep  2 17:54 /dev/ttyUSB0
crw-rw---- 1 root dialout 188, 1 Sep  2 17:54 /dev/ttyUSB1
crw-rw---- 1 root dialout 188, 2 Sep  3 14:30 /dev/ttyUSB2
crw-rw---- 1 root dialout 188, 3 Sep  2 17:54 /dev/ttyUSB3
pi@serverlan:~ $ rigctl -m 370 -r /dev/ttyUSB2 -t 7100 -s 19200

Rig command: f
Frequency: 7185000

Rig command: m
Mode: LSB
Passband: 3000

Rig command: ^C
pi@serverlan:~ $
```

The `ls` command shows the serial ports on my RaspberryPI, ttyUSB0/1 is my FT991 and ttyUSB2/3 is my IC-7100. I know this by looking at the output of `dmesg`. The next step is to test the interface to the radio using the `rigctl` command. 

Once that is working you can now run the `rigctld` command to expose the rigctl to any other machines on your network. This is useful so you can update a website and control the rig remotely or use logging software all simultaneously. 

It is worth noting that there is no security at all on rigctld so ensure you only expose this to a known network and not the Internet as a whole.

### Getting an @sign and setting up a wavi page
Your @sign is you unique id on the @platform, it's nice to have your callsign as your @sign like I do. If you get a free @sign from [The @ Company](https://atsign.com) and you are reading this let me know directly what that free @sign is and I can add your callsign @sign to your account for FREE for a limited time.

Once you have your @sign you can activate it with any @app, but using CATWEB probably makes the most sense! 
As you activate you will be asked to save your "keys". This is just a file that contains the cryptographic keys to your @sign. The keys were "cut" by your phone, so no one else has them so keep them safe. You will also need them for the next step.

If you would like to customize your @awvi page then download @wavi which is available at the [App Store](https://apps.apple.com/us/app/persona/id1527182357) or [Play store](https://play.google.com/store/apps/details?id=com.atsign.at_settings). You will need your keys file that you saved earlier to get @wavi online.

Use the @wavi app to set up any information you want to share with the world. You control all the information and you can add pure HTML/JS etc to customize your page. More clues on how to do that can be found [here](https://wavi.ng/@wavi). 
