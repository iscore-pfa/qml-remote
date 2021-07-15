/*
  * button to hide the top panel :
  * - at the top right of the interface
  * - hide triggers, scoreSpeeds
  * - play and pause buttons and the main speed are always visible
  */

import QtQuick 2.0
import QtQuick.Controls 2.12

Button {
    width: scoreSpeed.height

    background: Rectangle {
        width: parent.width; height: parent.height
        color: "#363636"
    }

    contentItem: Image {
        id: indicator

        width: parent.height; height: parent.height 
        anchors.verticalCenter: parent.verticalCenter
        source: !scoreTriggers.visible
                ? scoreHideButton.pressed
                  ? "../Icons/indicator_on.png"
                  : "../Icons/indicator.png"
                : scoreHideButton.pressed
                  ? "../Icons/indicator_hidden_on.png"
                  : "../Icons/indicator_hidden.png"
    }

    onReleased: {
        scoreTriggers.visible = ! scoreTriggers.visible
        scoreSpeeds.visible = ! scoreSpeeds.visible
        ipAddress.visible = ! ipAddress.visible
        window.state = scoreSpeeds.visible ? "" : "hidden"
        scorePlayPauseStop.state = scoreSpeeds.visible ? "" : "hidden"
    }
}
