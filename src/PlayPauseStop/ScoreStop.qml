/*
  * Stop button :
  * - at the top left of the interface with others buttons
  * - synchronize with score
  * - stop button pressed :
  *     - stop in score
  *     - play button displayed instead of pause button
  */

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.3

import Variable.Global 1.0

Button {

    width: parent.width; height: parent.width
    hoverEnabled: true

    // Allow to click on buttons and leave while pressing
    onHoveredChanged: {
        if (stopButton.state === 'stopOn') {
            stopButton.state = ''
        }
    }

    // Change the button color when it is pressed
    onPressed: {
        stopButton.state = 'stopOn'
        if (playPause.isConnected()) {
            playPause.stopClicked()
        }
    }

    // Specify the behavior of a button when it is clicked on
    onReleased: {
        stopButton.state = ''
        socket.sendTextMessage('{ "Message": "Stop" }')
        scoreTimeline.stopTimeline()
    }

    background: Rectangle { id: zone; color: Skin.darkGray }

    contentItem: Image {
        id: stopButton

        sourceSize { width: parent.width; height: parent.width }
        clip: true
        source: "../Icons/stop_off.png"

        states: [
            State {
                name: "stopOn"

                PropertyChanges {
                    target: stopButton
                    source: "../Icons/stop_on.png"
                }
            },
            State {
                name: "hoveredStop"

                PropertyChanges {
                    target: stopButton
                    source: "../Icons/stop_hover.png"
                }
            }
        ]
    }    
}
