# Linux-screencaster

##### Command line screencaster for Linux

Basic front end to `byzanz-record` that allows you to define an area to start recording then clicking an icon when you wish to stop.

##### Dependencies:
The following packages are required
```
$ sudo apt-get install yad
$ sudo apt-get install byzanz
$ sudo apt-get install libx11-dev
```

If no icon is provided `yad` will still be functional but will display a question mark, download an icon, rename it `record.png` and place it within the same directory as `gif.sh`.

##### Recording:

* Make `gif.sh` executable
* Execute `./gif.sh`
* Drag a selection to record
* Once done click the icon within the notification tray

##### Known issues:

* Do not manually execute `xrectsel`, by manually I mean double clicking it, I'm not sure how to address this issue though there isn't much reason to manually execute it
* `xrectsel` selections can look a little buggy though this doesn't reflect on the actual selected area
* Recording timer can carry on beyond a stopped recording, this is because it relies on byzanz process presence and for larger recordings it continues to compile behind the scenes even after the recording has stopped though again, only cosmetic
