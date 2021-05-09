import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.12

ColumnLayout{
    spacing: 5
    height: 200
    width: window.width/4
    ListView{
        id:sliderList
        clip: true
        spacing: 10
        Layout.fillHeight: parent.height
        Layout.fillWidth: parent.height
        Layout.margins: 5
        //orientation: parent.Vertical
        snapMode: ListView.SnapToItem
        model: ListModel {
            id: colorpickerListModel
        }
        delegate: ScoreColorpicker{
            id: colorpicker
            //controlName: myName
            anchors.left: parent.left
            anchors.right: parent.right
            //controlColor: "#f6a019"
            //controlId: myId
            //from: myFrom
            //value: myValue
            //to: myTo
            //controlPath: path
            //stepSize: myStepSize
            //onMoved: {
            //    socket.sendTextMessage('{ "Message": "ControlSurface","Path":'.concat(slider.controlPath,
            //                            ', "id":',slider.controlId, ', "Value": {"Float":',slider.value, '}}'))
            }
        }
    }
    Connections{
        function onAppendColorpicker(s) {
            function find(cond) {
                for(var i = 0; i < colorpickerListModel.count; ++i) if (cond(colorpickerListModel.get(i))) return i;
                return null
            }
            var a = find(function (item) { return item.id === JSON.stringify(s.id) }) //the index of m.Path in the listmodel
            if(a === null){
                var tmpFrom, tmpValue, tmpTo
                var tmpStepSize
                switch(s.uuid){
                    // Float Slider
                    case "af2b4fc3-aecb-4c15-a5aa-1c573a239925":
                        tmpFrom = s.Domain.Float.Min
                        tmpValue = s.Value.Float
                        tmpTo = s.Domain.Float.Max
                        tmpStepSize = 0.0
                        break
                    // Int Slider
                    case "348b80a4-45dc-4f70-8f5f-6546c85089a2":
                        tmpFrom = s.Domain.Int.Min
                        tmpValue = s.Value.Int
                        tmpTo = s.Domain.Int.Max
                        tmpStepSize = 1
                        break
                }
                sliderListModel.insert(sliderListModel.count,{ myName: JSON.stringify(s.Custom),
                                            path: JSON.stringify(s.Path),
                                            myId: JSON.stringify(s.id),
                                            myFrom: JSON.stringify(tmpFrom),
                                            myValue: JSON.stringify(tmpValue),
                                            myTo: JSON.stringify(tmpTo),
                                            myStepSize: tmpStepSize});
            }
        }
    }
}