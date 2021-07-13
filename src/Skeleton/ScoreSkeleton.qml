/*
  * Skeleton of the app all objects which are displayed
  * - Buttons (top left) :
  *     - Play, Pause, stop
  *     - IP, connection, disconnection
  * - list of triggers (top left)
  * - main speed (top right)
  * - list of speeds (top right)
  * - list of control surface (in the middle)
  * - time line (bottom)
  */

import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebSockets 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0

import Variable.Global 1.0

import "qrc:/WebSocket"
import "qrc:/IpAddress"
import "qrc:/PlayPauseStop"
import "qrc:/Trigger"
import "qrc:/Speed"
import "qrc:/Speeds"
import "qrc:/HideButton"
import "qrc:/ControlSurface"
import "qrc:/Timeline"

Item {
    id: window

    // Called when the remote is disconnected from score
    function disconnect() {

        // Clear trigger, speed, control surface... lists
        scoreTriggers.clearTriggerList()
        scoreSpeeds.clearSpeedList()
        scoreControlSurfaceList.clearControlSurfaceList()

        // Reset timeline
        scoreTimeline.stopTimeline()
    }

    anchors.fill: parent

    // A field to save the IP address
    Settings {
        id: settings

        property string ip_address: "127.0.0.1"
    }

    // Creating the websocket
    ScoreWebSocket {
        id: socket
    }

    // Creating the IP address button object
    ScoreIpAddress {
        id: ipAddress

        signal playPauseStopMessageReceived(var n)

        anchors { left: parent.left; top: parent.top }
        width: 20 + ( ( 0.3 * window.width + 0.7 * window.height ) / 20 )
    }

    // Creating play, pause and stop button objects
    ScorePlayPauseStop {
        id: scorePlayPauseStop
        
        signal playPauseStopMessageReceived(var n)
        signal scorePlayPauseStopMessageReceived(var n)
        signal connectedToScore()
        signal disconnectedFromScore()

        height: 2 * this.width; width: ipAddress.width
        anchors { left: ipAddress.left; top: ipAddress.bottom }
    }

    /*
    // TODO : Creating the volume slider object
    ScoreVolume {
        id: scoreVolume
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        signal intervalMessageReceived(var n)
        signal intervalsMessageReceived(var n)

    }*/

    // Creating the trigger list
    ScoreTriggers {
        id: scoreTriggers
        
        signal triggerMessageReceived(var n)
        signal clearTriggerList()

        anchors {
            left: ipAddress.right; right: scoreSpeed.left
            top: parent.top; bottom: scorePlayPauseStop.bottom; margins: 5
        }
    }

    // Creating the button to hide the top panel (triggers, speeds)
    ScoreHideButton {
        id: scoreHideButton

        anchors {
            right: parent.right
            top: parent.top; bottom: scoreSpeed.bottom
            rightMargin: 5; topMargin: 5
        }
    }

    // Creating the speed list
    ScoreSpeeds {
        id: scoreSpeeds

        signal intervalMessageReceived(var n)
        signal intervalsMessageReceived(var n)
        signal clearSpeedList()

        anchors {
            left: scoreSpeed.left; right: parent.right
            top: scoreSpeed.bottom; bottom: scorePlayPauseStop.bottom
            rightMargin: 5; topMargin: 5
        }
    }

    // Creating the main scenario speed slider object
    ScoreSpeed {
        id: scoreSpeed

        signal intervalMessageReceived(var n)
        signal intervalsMessageReceived(var n)

        anchors {
            right: scoreHideButton.left; top: parent.top
            rightMargin: 5; topMargin: 5
        }
    }

    // Creating the control surface list
    ScoreControlSurfaceList {
        id: scoreControlSurfaceList

        signal controlSurfacesMessageReceived(var n)
        signal clearControlSurfaceList()

        anchors {
            left: parent.left; right: parent.right
            top: scorePlayPauseStop.bottom; bottom: scoreTimeline.top
            topMargin: 5
        }
    }

    // Creating the timeline slider object
    ScoreTimeline {
        id: scoreTimeline

        signal intervalsMessageReceived(var n)

        anchors.bottom: parent.bottom
    }

    // State in which the top panel (triggers, speeds) is hidden
    states: State {
        name: "hidden"

        PropertyChanges {
            target: ipAddress
            width: 1.4 * scoreHideButton.height
        }

        PropertyChanges {
            target: scorePlayPauseStop
            width: 2 * ipAddress.width; height: ipAddress.width
            anchors { left: window.left; top: window.top }
        }

        PropertyChanges {
            target: scoreTriggers
            anchors {
                left: scorePlayPauseStop.right; right: scoreSpeed.left
                top: parent.top; bottom: scorePlayPauseStop.bottom
                margins: 5
            }
        }

        PropertyChanges {
            target: scoreControlSurfaceList
            anchors.top: scoreHideButton.bottom
        }
    }
}
