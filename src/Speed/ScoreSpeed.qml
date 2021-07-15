/*
  * Speed of the main scenario :
  * - at the top right of the interface
  * - modify its value in the remote modifies the value in score
  */

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQml 2.12

import Variable.Global 1.0

import "qrc:/ObjectSkeletons"

ScoreSliderSkeleton {
    id: globalSpeed

    property var path

    Connections {
        target: scoreSpeed

        // Managing the first speed message sent by score
        function onIntervalMessageReceived(m) {
            var IntervalsObject = m.Intervals
            // The global path is the first one to be created by score
            if (globalSpeed.path == null) {
                globalSpeed.value = JSON.stringify(m.Speed) * 720 / 6
                globalSpeed.path = JSON.stringify(m.Path)
            }
        }

        // Updating when speed is changed on score
        function onIntervalsMessageReceived(m) {
            var IntervalsObject = m.Intervals
            // The global path is the first one to be created by score
            if (IntervalsObject[0] && globalSpeed.path === JSON.stringify(IntervalsObject[0].Path)) {
                globalSpeed.value = JSON.stringify(IntervalsObject[0].Speed) * 720 / 6
            }
        }
    }

    controlName: "Speed"
    height: window.height <= 600 ? 30 : 5 + window.height / 25; width: window.width / 2
    from: -120; value: 100; to: 600
    controlColor: Skin.brown

    // Send a message to Score to update its progress' timeline
    onMoved: {
        socket.sendTextMessage(
                    `{ "Message": "IntervalSpeed", "Path": ${globalSpeed.path}, "Speed": ${globalSpeed.value * 6 / 720} }`)
    }
}
