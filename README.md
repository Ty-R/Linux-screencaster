# Linux-screencaster

#### Command line screencaster for Linux

Basic front end to `byzanz-record` that allows you to define an area to start recording then clicking an icon when you wish to stop.

#### Dependencies:

The following packages are required

```
$ sudo apt-get install yad
$ sudo apt-get install byzanz
$ sudo apt-get install libx11-dev
```

If no icon is provided `yad` will still be functional but will be default, download an icon, rename it `record.png` and place it within the same directory as `gif.sh`.

#### Setup:

Download or clone the repository:

`$ git clone https://github.com/TyRoberts/Linux-screencaster.git`

* Make `gif.sh` executable:

`$ chmod +x gif.sh`

#### Usage:

**To record:**

* Execute `gif.sh`

`$ ./gif.sh`

* Drag a selection to record
* Once done click the icon within the notification tray
* The terminal will output the save location, (Holding CTRL and clicking the path will open that location)
* Gifs are number named  - e.g. `72364785.gif`

**Archive:**

Each time you begin a new recording any gifs currently present within the parent directory will be moved to an `archives` directory so to keep the parent directory clean, due to gifs being number named - they should be ordered correctly in the archives too, by most recent last.

---

**Note:**

For desktop environments that don't have a notification tray by default (Unity for example) you can modify `gif.sh` to not use `--notification` and instead use a dialogue for example or look into a package that adds a notification tray.
