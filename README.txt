##### Command line screencaster for Linux

Basic front end to `byzanz-record` that allows you to define an area to start recording then clicking an icon when you wish to stop.

##### Dependencies:

* yad (uses yad notification so DE like Unity may need further tweaking)
* byzanz-record
* libx11-dev
* A suitable icon (not a dependency but it's nice to have - I like `https://www.iconfinder.com/icons/118789/download/png/128`) and mane it 'record.png'

##### Getting started:

* Make `gif.sh` executable
* Execute `./gif.sh`

##### Known issues:

* Do not manually execute `xrectsel`, by manually I mean double clicking it, I'm not sure how to address this issue though there isn't much reason to manually execute it.
* `xrectsel` selections can look a little buggy though this doesn't reflect on the actual selected area
* Recording timer can carry on beyond a stopped recording, this is because it relies on byzanz process presence and for larger recordings it continues to compile behind the scenes even after the recording has stopped though again, only cosmetic


