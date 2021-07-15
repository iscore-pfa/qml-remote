/*
  * Play and Pause buttons :
  * - at the top left of the interface with others buttons
  * - visible when the remote is connected to score
  * - synchronize with score
  * - play button pressed :
  *     - play in score
  *     - pause button displayed
  * - pause button pressed :
  *     - pause in score
  *     - play button displayed
  */

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.3

import Variable.Global 1.0

Button {

    width: parent.width; height: parent.width
    hoverEnabled: true

    // Detecting when buttons are pressed whether in the interface or on score
    function stopClicked() {
        pauseButton.state = 'playDisplayed'
    }

    function isConnected() {
        return (pauseButton.state !== '')
    }

    function isPaused() {
        return (pauseButton.state === 'hoveredPlayOff')
    }

    function playPressInScore() {
        pauseButton.state = 'pauseDisplayed'
    }

    function pausePressInScore() {
        pauseButton.state = 'playDisplayed'
    }

    function connectedToScore() {
        pauseButton.state = 'playDisplayed'
    }

    function disonnectedFromScore() {
        pauseButton.state = ''
    }

    // Allow to click on buttons and leave while pressing
    onHoveredChanged: {
        switch (pauseButton.state) {
        case 'connectionOn':
            pauseButton.state = ''
            break

        case 'connectionOff':
            pauseButton.state = ''
            break

        case 'playPressed':
            pauseButton.state = 'playDisplayed'
            break
        }
    }

    // Change the button color when it is pressed
    onPressed: {
        switch (pauseButton.state) {
        case '':
            pauseButton.state = 'connectionOn'
            break

        case 'playDisplayed':
            pauseButton.state = 'playPressed'
            break
        }
    }

    // Specify the behavior of a button when it is clicked on
    onReleased: {
        switch (pauseButton.state) {
        case 'connectionOn':
            socket.active = !socket.active
            break

        case 'playPressed':
            pauseButton.state = 'pauseDisplayed'
            socket.sendTextMessage('{ "Message": "Play" }')
            break

        case 'pauseDisplayed':
            pauseButton.state = 'playDisplayed'
            socket.sendTextMessage('{ "Message": "Pause" }')
            break

        default:
        }
    }

    background: Rectangle { id: zone; color: Skin.darkGray }

    contentItem: Image {
        id: pauseButton

        sourceSize { width: parent.width; height: parent.width }
        source: "../Icons/connection.png"
        clip: true

        states: [
            State {
                name: "connectionOn"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/connection_on.png"
                }
            },
            State {
                name: "connectionOff"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/connection.png"
                }
            },
            State {
                name: "playDisplayed"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/play_glob_off.png"
                }
            },
            State {
                name: "playPressed"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/play_glob_on.png"
                }
            },
            State {
                name: "hoveredConnection"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/connection_hover.png"
                }
            },
            State {
                name: "pauseDisplayed"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/pause_on.png"
                }
            },
            State {
                name: "hoveredPlayOff"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/play_glob_hover.png"
                }
            },
            State {
                name: "hoveredPlayOn"

                PropertyChanges {
                    target: pauseButton
                    source: "../Icons/pause_hover.png"
                }
            }
        ]
    }
}
