/*
  * Control Surface :
  * - main object of the remote
  * - a control located in a control surface in score
  * can be modified in the application
  * - a control surface contains :
  *     - a name
  *     - several control lists :
  *         - slider (int, float, log)
  *         - impulse button
  *         - button
  *         - colorpicker
  *         - position
  *         - combobox
  * - handle message from score relayed by ScoreSkeleton.qml
  */

import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

import "qrc:/ControlSurface/Controls/Colorpicker"
import "qrc:/ControlSurface/Controls/Slider"
import "qrc:/ControlSurface/Controls/Button"
import "qrc:/ControlSurface/Controls/Position"
import "qrc:/ControlSurface/Controls/ImpulseButton"
import "qrc:/ControlSurface/Controls/ComboBox"


import Variable.Global 1.0

Column {
    id: controlSurfaceListColumn

    property string name

    // Receiving information about controls in a control surface from score
    Connections {
        target: controlSurface

        // Adding controls in a control surface
        function onAppendControls(m) {
            controlSurfaceName.text = m.Name
            var i = 0
            var controlMessage = m.Controls[i]
            while (controlMessage) {
                switch (controlMessage.uuid) {
                case Uuid.floatSliderUUID:
                    // Float Slider
                    scoreSliders.appendSlider(controlMessage, i)
                    break

                case Uuid.logFloatSliderUUID:
                    // Log Float Slider
                    scoreSliders.appendSlider(controlMessage, i)
                    break

                case Uuid.intSliderUUID:
                    // Int Slider
                    scoreSliders.appendSlider(controlMessage, i)
                    break

                case Uuid.impulseButtonUUID:
                    // Impulse Button
                    scoreImpulseButtons.appendImpulseButton(controlMessage)
                    break

                case Uuid.buttonUUID:
                    // Button
                    scoreButtons.appendButton(controlMessage)
                    break

                case Uuid.colorPickerUUID:
                    // Colorpicker
                    scoreColorpicker.visible = true
                    scoreColorpicker.appendColorpicker(controlMessage)
                    break

                case Uuid.positionUUID:
                    // Position
                    scorePosition.visible = true
                    scorePosition.appendPosition(controlMessage)
                    break

                case Uuid.comboBoxUUID:
                    // ComboBox
                    scoreComboBox.appendComboBox(controlMessage)
                    break

                default:
                    break;
                }
                i++
                controlMessage = m.Controls[i]
            }
        }

        // Modifying controls in a control surface
        function onModifyControl(m) {

            if (m.Message === "ControlSurfaceControl") {
                scoreSliders.modifySlider(m)
                scoreColorpicker.modifyColorpicker(m)
                scoreImpulseButtons.modifyImpulseButton(m)
                scoreButtons.modifyButton(m)
            }
        }
    }

    spacing: 5

    // Control surface name
    Button {
        id: controlSurfaceNameButton
        width: controlSurfaceListColumn.width
        height: window.height <= 600 ? 30 : 5 + window.height / 25

        background: Rectangle {
            anchors.fill: parent
            color: Skin.gray1
        }

        contentItem: Item {
            anchors.fill: parent
            Text {
                id: controlSurfaceName
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 5
                text: name
                color: controlSurfaceNameButton.pressed ? Skin.orange : Skin.white
                font.pointSize:  window.width <= 500
                                 ? 10
                                 : window.width <= 1200
                                   ? 12
                                   : 15
            }

            Image {
                id: indicator
                anchors.verticalCenter: parent.verticalCenter
                width: parent.height
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: 5
                source: !controlList.visible
                        ? controlSurfaceNameButton.pressed
                          ? "../Icons/indicator_on.png"
                          : "../Icons/indicator.png"
                        : controlSurfaceNameButton.pressed
                          ? "../Icons/indicator_hidden_on.png"
                          : "../Icons/indicator_hidden.png"
            }
        }

        onReleased: {
            controlList.visible = ! controlList.visible
        }
    }

    // List of controls
    Flow {
        id: controlList

        width: parent.width
        spacing: 5

        // List of sliders
        ScoreSliders {
            id: scoreSliders

            signal appendSlider(var msg)
            signal modifySlider(var msg)
        }

        // List of Impulse buttons
        ScoreImpulseButtons {
            id: scoreImpulseButtons

            signal appendImpulseButton(var msg)
            signal modifyImpulseButton(var msg)
        }

        // List of buttons
        ScoreButtons {
            id: scoreButtons

            signal appendButton(var msg)
            signal modifyButton(var msg)
        }

        // List of colorpickers
        ScoreColorpicker {
            id: scoreColorpicker

            signal appendColorpicker(var msg)
            signal modifyColorpicker(var msg)

            visible: false
        }

        // List of positions
        ScorePosition {
            id: scorePosition

            signal appendPosition(var msg)
            signal modifyPosition(var msg)

            visible: false
        }

        // List of comboBoxes
        ScoreComboBoxes {
            id: scoreComboBox

            signal appendComboBox(var msg)
        }
    }
}
