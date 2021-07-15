/*
  * Combobox control :
  * - in a list of comboboxes in a control surface
  * - modify combobox value in the remote modify
  * the value of this combobox in score
  */

import QtQuick 2.15
import QtQuick.Controls 2.12

import Variable.Global 1.0

ComboBox {
    id: comboBox

    property string controlCustom
    property string controlDomain
    property string controlValueType
    property string controlValueData
    property int controlId
    property string controlUuid
    property string controlSurfacePath

    Connections {
        target: comboBoxItem

        function onAppendItems(message, path) {
            if (message) {
                controlCustom = message.Custom
                controlId = message.id
                controlUuid = message.uuid
                controlSurfacePath = path
                var i = 0
                var itemMessage = message.Values[i]
                while (itemMessage) {
                    comboBoxItemsListModel.append({
                                                      "_num": JSON.stringify(itemMessage[1]),
                                                      "_name": itemMessage[0]
                                                  })
                    i++
                    itemMessage = message.Values[i]
                }
            }

            // Initialize the current value of the combobox
            var currentVal = JSON.stringify(message.Value)
            for (var j = 0; j < comboBoxItemsListModel.count; ++j) {
                if (comboBoxItemsListModel.get(j)._num === currentVal) {
                    comboBox.currentIndex = j
                }
            }
        }
    }

    implicitHeight: window.height<= 500
                    ? 30
                    : 5 + window.height / 25
    implicitWidth: (controlSurfaceListColumn.width <= 500
            ? (controlSurfaceListColumn.width)
            : (controlSurfaceListColumn.width >= 1200
               ? 400
               : controlSurfaceListColumn.width / 3))
    valueRole: '_num'
    textRole: '_name'

    model: ListModel {
        id: comboBoxItemsListModel
    }

    delegate: ItemDelegate {
        id: delegateItem

        property string num: _num
        property string name: _name

        width: comboBox.width; height: 40
        highlighted: comboBox.highlightedIndex === index

        contentItem: Text {
            text: name
            color: Skin.white
            font.pointSize: parent.width <= 200
                            ? 10
                            : parent.width >= 500
                              ? parent.height / 2
                              : 15
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            opacity: delegateItem.highlighted ? 1 : 0.3
            color: delegateItem.highlighted ? Skin.brown : Skin.gray1
        }
    }

    indicator: Image {
        id: indicator

        width: parent.height; height: parent.height
        anchors { right: parent.right; verticalCenter: parent.verticalCenter }
        source: !popup.visible
                ? comboBox.pressed
                  ? "../../../Icons/indicator_on.png"
                  : "../../../Icons/indicator.png"
                : comboBox.pressed
                  ? "../../../Icons/indicator_hidden_on.png"
                  : "../../../Icons/indicator_hidden.png"
    }

    contentItem: Text {
        leftPadding: 5
        rightPadding: comboBox.indicator.width + comboBox.spacing
        text: qsTr(controlCustom) + ": " + comboBox.displayText
        color: Skin.white
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.pointSize: parent.width <= 200
                        ? 10
                        : parent.width >= 500
                          ? parent.height / 2
                          : 15
    }

    background: Rectangle {
        implicitWidth: 120; implicitHeight: 40
        color: Skin.gray1
        border.color: comboBox.pressed ? Skin.brown : Skin.brown
    }

    popup: Popup {
        width: comboBox.width; height: 150
        y: comboBox.height - 1
        padding: 1

        contentItem: ListView {
            clip: true
            height: 150
            model: comboBox.popup.visible ? comboBox.delegateModel : null
            currentIndex: comboBox.highlightedIndex

            ScrollBar.vertical: ScrollBar {
                id: scrollBar

                width: 30
                anchors.right: parent.right
                active: true
                policy: ScrollBar.AsNeeded
                snapMode: ScrollBar.SnapAlways

                contentItem: Rectangle {
                    id: scrollBarContentItem
                    visible: scrollBar.size < 1
                    color: scrollBar.pressed ? Skin.orange : Skin.lightGray
                }

                background: Rectangle {
                    id: scrollBarBackground

                    width: scrollBarContentItem.width + 20
                    color: Skin.darkGray
                }
            }
        }

        background: Rectangle {
            color: Skin.gray1
            border.color: Skin.brown
        }
    }

    onCurrentValueChanged: {
        socket.sendTextMessage(
                    `{ "Message": "ControlSurface","Path": ${comboBox.controlSurfacePath}, "id": ${comboBox.controlId}, "Value": ${comboBox.currentValue} }`)
    }
}
