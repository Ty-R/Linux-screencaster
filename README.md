# Linux-screencaster

#### Command line gif recorder for Linux

A simple way to interface with `byzanz-record` which allows you to define an area to start recording, and click an icon when you wish to stop.

#### Package dependencies:

The following packages are required

```
$ apt-get install yad
$ apt-get install byzanz
$ apt-get install libx11-dev
$ apt-get install slop
```

#### Setup:

Download or clone the repository:

`$ git clone https://github.com/TyRoberts/Linux-screencaster.git`

* Make `gif.sh` executable:

`$ chmod +x gif.sh`

#### Usage:

**To record:**

* Execute `gif.sh`

`$ ./gif.sh`

Areas are selectable two ways:

* clicking a window will capture the entire window
* Clicking and dragging an area will capture the selected area

Clicking the icon in the **notification tray** will stop and save the recording, the terminal will output the name of the gif, and the save location.

Recordings can be cancelled at any point by pressing `CTRL + C`.

#### Configure

There isn't much to configure but at the top of the main script sits:

```
icon='player_record'  # The icon used by Yad - can be a system icon or local image
countdown=3           # Countdown in seconds before recording starts
archive=true          # Move old gifs into a directory instead of deleting them
```


