qml-remote
===

Repository for a project aiming at developing an application, allowing to deport the interface of [ossia-score](https://github.com/ossia/score) on a mobile device, and thus to use the software remotely.

The project aims to deport the use of this software on a mobile connected device. The goal is to allow the user to execute his scenario remotely, and to vary the parameters of his show from the stage, thus avoiding numerous trips to his computer.

Tree Structure
===

All files are located in the `src/` directory, which itself is divided into several subdirectories :

- **ControlSurface :** Contains the list of control surfaces and all different type of controls (sliders, buttons, comboboxes...)
- **Icons :** Contains all icons used in the app (button icons...)
- **ObjectSkeletons :** Contains a skeleton slider used in the speed sliders (Speed and Speeds directories)
- **PlayPauseStop :** Contains buttons that allow you to interract with time (play, pause and stop buttons)
- **Skeleton :** Contains the skeleton file of the app. This file instanciate all of the obects displayed on the srceen.
- **Speed :** Contains the speed slider of the main scenario
- **Speeds :** Contains the list of speed sliders of the sub-scenarios
- **Timeline :** Contains the timeline of the main scenario. It is an additional feature compared to ossia score
- **Triggers :** Contains the list of triggers
- **Utility :** Contains some global functions and variables
- **Volume :** Contains the volume of the main scenario. Does not work at the momenbt
- **WebSocket :** Contains the file which etablishes the websocket connection

Getting Started
===

* Download the latest release : https://github.com/ossia/qml-remote/releases/latest
* Unzip the release
* Run these commands
```
    cd path/to/dir
    tar -xzvf build-wasm.tar.gz
    cd build-wasm/
    python -m SimpleHTTPServer 8087 // python -m http.server 8087 for windows
```
* Go to : http://[ipAdress]:8087/PFA11.html
