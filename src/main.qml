import QtQuick 2.12
import QtQuick.Window 2.12

import QtQuick.VirtualKeyboard 2.15
import QtQuick.VirtualKeyboard.Styles 2.15
import QtQuick.VirtualKeyboard.Settings 2.15

import "Skeleton"

import Variable.Global 1.0

// Creation of the main window of the application
Window {
    id: mainWindow
    width: 1000
    height: 600
    visible: true
    title: qsTr("Remote Control")
    color: Skin.green

    Keyboard {

    }

    // Creation of the application's skeleton
    //ScoreSkeleton {}
}
