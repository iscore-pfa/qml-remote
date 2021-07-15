/*
  * Slider skeleton used by
  * - ScoreSpeed.qml
  * - ScoreVolume.qml
  */
  
import QtQuick 2.0
import QtQuick.Controls 2.12

import Variable.Global 1.0

Slider {

    id: control

    property string controlName: "ControlName"
    property string controlPath: "ControlPath"
    property int controlId
    property string controlUuid
    property string controlUnit: ""
    property color controlColor: Skin.orange

    implicitWidth: 300; implicitHeight: 20

    // Slider name
    Text {
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        text: ' ' + controlName + ':'
        color: Skin.white
        font.pointSize: ((parent.height + parent.width) / 30) >= parent.height / 2
                        ? parent.height / 2
                        : (parent.height + parent.width) / 30.0
    }

    // Slider value
    Text {
        anchors { right: parent.right; verticalCenter: parent.verticalCenter }
        text: control.value.toFixed(3) + ' ' + controlUnit
        color: Skin.white
        font.pointSize: ((parent.height + parent.width) / 30) >= parent.height / 2
                        ? parent.height / 2
                        : (parent.height + parent.width) / 30.0
    }

    // No handle
    handle: Rectangle {}

    background: Rectangle {
        implicitWidth: parent.width; implicitHeight: parent.height
        color: Skin.gray2
        border { width: 1; color: controlColor }

        Rectangle {
            width: control.visualPosition * parent.width - y; height: parent.height
            color: controlColor
        }
    }
}
