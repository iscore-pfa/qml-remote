/*
  * Volume of the main scenario :
  * - not used in the remote for now
  */

import QtQuick 2.0
import QtQuick.Layouts 1.12

import "qrc:/ObjectSkeletons"

ScoreSliderSkeleton {
    id: scoreGlobalVolume

    property string path: "first"
    property double totalVolume // The total speed goes from -120 to 600

    Connections {
        target: scoreVolume

        // To have the path
        function onIntervalMessageReceived(m) {
            var IntervalsObject = m
            if (scoreGlobalVolume.path === "first") {
                // The global path is the first one to be created by score
                scoreGlobalVolume.path = JSON.stringify(m.Path)
            }
        }

        // To set the volume from score
        function onIntervalsMessageReceived(m) {
            var IntervalsObject = m.Intervals
            if (IntervalsObject[0] && scoreGlobalVolume.path === JSON.stringify(
                        IntervalsObject[0].Path)) {
                // The global path is the first one to be created by score
                scoreGlobalVolume.value = 1 - JSON.stringify(IntervalsObject[0].Gain)
            }
        }
    }

    height: 20; width: window.width / 4
    anchors.horizontalCenter: parent.horizontalCenter
    controlName: "Volume"
    controlUnit: "dB "
    controlColor: Skin.brown
    from: -40; value: -20; to: 0

    // Sends a message to Score to update volume
    onMoved: {
        socket.sendTextMessage(
                    `{ "Message": "IntervalGain", "Path": ${scoreGlobalVolume.path}, "Gain": ${scoreGlobalVolume.value} }`)
    }
}
