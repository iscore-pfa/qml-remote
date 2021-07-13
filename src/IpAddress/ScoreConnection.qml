/*
  * Connection Button :
  * - at the top left of the interface with others buttons
  * - visible when the remote is disconnected form score
  * - when the button is pressed: a window appears asking for IP address
  */

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12

import Variable.Global 1.0

Button {

    hoverEnabled: true
    onPressed: ipButton.state = "ip_on"
    onReleased: { onClicked: ipDialog.open() }
    background: Rectangle { id: zone; color: Skin.darkGray }

    onHoveredChanged: {
        if (ipButton.state === 'ip_on') {
            ipButton.state = ""
        }
    }

    contentItem: Image {
        id: ipButton
        sourceSize { width: parent.width; height: parent.width }
        source: "../Icons/ip_address.png"
        clip: true

        states: State {
            name: "ip_on"

            PropertyChanges {
                target: ipButton
                source: "../Icons/ip_address_on.png"
            }
        }
    }

    // Connection window
    Dialog {
        id: ipDialog

        title: "Connection"
        width: 300; height: 100

        contentItem: Rectangle {
            anchors.fill: parent
            color: Skin.gray1

            Rectangle {
                id: connectionWindow

                anchors { fill: parent; margins: 10 }
                color: Skin.gray1

                Rectangle {
                    width: parent.width; height: 50
                    anchors.top: parent.top
                    color: Skin.gray1

                    Text {
                        id: ipText

                        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
                        text: "Ip address"
                        color: Skin.white
                    }

                    // TextField to enter the IP address
                    TextField {
                        id: ipInput

                        width: parent.width <= 160 ? 65 : 100
                        anchors { left: ipText.right; leftMargin: 10; verticalCenter: parent.verticalCenter }
                        text: settings.ip_address
                        color: Skin.white

                        background: Rectangle {
                            anchors.fill: parent
                            color: Skin.darkGray
                            border.color: Skin.brown
                        }
                    }
                }

                // OK button
                Button {
                    id: okButton

                    width: 75; height: 30
                    anchors { right: cancelButton.left; bottom: parent.bottom; rightMargin: 10 }

                    contentItem: Text {
                        id: okButtonText

                        color: Skin.white
                        text: qsTr("OK")
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onPressed: {
                        switch (okButton.state) {
                        case "hoveredOK":
                            okButton.state = "pressedOK"
                            break
                        }
                    }

                    onReleased: {
                        settings.ip_address = ipInput.text
                        ipDialog.close()
                    }

                    onHoveredChanged: {
                        switch (okButton.state) {
                        case "":
                            okButton.state = "hoveredOK"
                            break

                        case "hoveredOK":
                            okButton.state = ""
                            break

                        case "pressedOK":
                            okButton.state = ""
                            break
                        }
                    }

                    background: Rectangle {
                        id: okButtonBackground

                        anchors.fill: parent
                        color: Skin.darkGray
                        border { color: Skin.gray3; width: 0.5}
                    }

                    states: [
                        State {
                            name: "hoveredOK"

                            PropertyChanges {
                                target: okButtonBackground
                                border.color: Skin.brown
                            }
                        },
                        State {
                            name: "pressedOK"

                            PropertyChanges {
                                target: okButtonBackground
                                border.color: Skin.orange
                                color: Skin.brown
                            }

                            PropertyChanges {
                                target: okButtonText
                                opacity: 0.5
                            }
                        }
                    ]
                }

                // Cancel button
                Button {
                    id: cancelButton

                    width: 75; height: 30
                    anchors { right: parent.right; bottom: parent.bottom }

                    contentItem: Text {
                        id: cancelButtonText
                        color: Skin.white
                        text: qsTr("Cancel")
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onPressed: {
                        switch (cancelButton.state) {
                        case "hoveredCANCEL":
                            cancelButton.state = "pressedCANCEL"
                            break
                        }
                    }

                    onReleased: {
                        ipInput.text = settings.ip_address
                        ipDialog.close()
                    }

                    onHoveredChanged: {
                        switch (cancelButton.state) {
                        case "":
                            cancelButton.state = "hoveredCANCEL"
                            break

                        case "hoveredCANCEL":
                            cancelButton.state = ""
                            break

                        case "pressedCANCEL":
                            cancelButton.state = ""
                            break
                        }
                    }

                    background: Rectangle {
                        id: cancelButtonBackground

                        anchors.fill: parent
                        color: Skin.darkGray
                        border { color: Skin.gray3; width: 0.5}
                    }

                    states: [
                        State {
                            name: "hoveredCANCEL"

                            PropertyChanges {
                                target: cancelButtonBackground
                                border.color: Skin.brown
                            }
                        },
                        State {
                            name: "pressedCANCEL"

                            PropertyChanges {
                                target: cancelButtonBackground
                                color: Skin.brown
                                border.color: Skin.orange
                            }

                            PropertyChanges {
                                target: cancelButtonText
                                opacity: 0.5
                            }
                        }
                    ]
                }
            }
        }
    }
}
