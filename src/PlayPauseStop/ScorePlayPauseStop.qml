/*
  * Contains buttons that allow you to interact with time :
  * - Play, Pause buttons
  * - stop button
  * - has 2 states :
  *     - "" : horizontal button list
  *     - "hidden" : vertical button list
  */

import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

Item {
    id: playPauseStop

    Connections {
        target: scorePlayPauseStop
        function onPlayPauseStopMessageReceived(m) {
            var messageObject = m.Message
            switch (messageObject) {
            case "Start":
                //send signal to playPause Button
                playPause.clicked()
                break

            case "Stop":
                //send signal to stop Button
                stop.clicked()
                scoreControlSurfaceList.clearListModel()
                break
            }
        }
        function onScorePlayPauseStopMessageReceived(m) {
            var messageObject = m.Message
            switch (messageObject) {
            case "IntervalPaused":
                playPause.pausePressInScore()
                break

            case "IntervalResumed":
                playPause.playPressInScore()
                break
            }
        }

        // Connect play/pause buttons with the socket instance
        function onConnectedToScore() {
            playPause.connectedToScore()
        }

        function onDisconnectedFromScore() {
            playPause.disonnectedFromScore()
        }
    }

    ScorePlayPause {
        id: playPause

        width: parent.width
        anchors { top: parent.top; left: parent.left }
    }

    ScoreStop {
        id: stop

        width: parent.width
        anchors { top: playPause.bottom; left: parent.left }
    }
    // State in which the top panel (triggers, speeds) is hidden and the button list is vertical
    states: State {
        name: "hidden"

        PropertyChanges {
            target: playPause
            width: parent.width / 2; height: parent.height
            anchors { top: parent.top; left: parent.left }
        }

        PropertyChanges {
            target: stop
            width: parent.width / 2; height: parent.height
            anchors { top: parent.top; left: playPause.right }
        }
    }
}
