# lico-update.sh

The lico-update.sh script is the new official machine update script for the new RESTful API on linuxcounter.net

  - Update your linuxcounter machines directly via this script without the need for log into your account
  - Automate the machine update by installing a cronjob by invoking a simple command

### Version
0.0.1  -  Initial version, mostly c&p'ed from the old script, but also modified for working with the new API and enhanced with bugfixes and better functions

### Installation

Download the file "lico-update.sh" from github, move it into your PATH and make it executable:

```sh
$ wget https://github.com/alexloehner/linuxcounter-update-examples/raw/master/_official/lico-update.sh
$ chmod +x lico-update.sh
$ sudo mv lico-update.sh /usr/local/bin/lico-update.sh
```
**Or** clone the repository in order to be able to contribute to the code, enhance the script, fixing bugs and sending pull requests:
```sh
$ git clone https://github.com/alexloehner/linuxcounter-update-examples.git
$ cd linuxcounter-update-examples/_official
$ sudo cp lico-update.sh /usr/local/bin/lico-update.sh
```

### Usage

First start the script by using the "-h" parameter to get some help:
```sh
$ lico-update.sh -h
```

You may use the interactive mode of the script for being guided through the machine registration and sending the data:
```sh
$ lico-update.sh -i
```

### License
----

GNU General Public License Version 3


**Free Software, Hell Yeah!**

