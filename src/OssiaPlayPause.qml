import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.3
import QtMultimedia 5.0
import QtQuick.Controls.Material 2.3

Button {
    hoverEnabled: true

    function stopClicked(){
        pauseButton.state = 'play_off'
    }
    function playGlobClicked(){
        pauseButton.state = 'disabledPause'
    }

    function isDisabled(){
        return (pauseButton.state === 'disabledPause')
    }
    function isConnected(){
        return (pauseButton.state != '')
    }
    function isPaused(){
        return (pauseButton.state === 'hoveredPlayOff')
    }

    onHoveredChanged: {if (pauseButton.state === 'hoveredPlayOff')
                            {pauseButton.state = 'play_off'}
                       else if (pauseButton.state === 'play_off')
                            {pauseButton.state = 'hoveredPlayOff'}
                       else if (pauseButton.state === 'play_on')
                            {pauseButton.state = 'hoveredPlayOn'}
                       else if (pauseButton.state === 'pause_on')
                            {pauseButton.state = 'hoveredPlayOn'}
                       else if (pauseButton.state === 'hoveredPlayOn')
                            {pauseButton.state = 'pause_on'}
    }
    onClicked: {
        if(pauseButton.state === ''){
            pauseButton.state = 'hoveredPlayOff'
                            socket.active = !socket.active
        } else if(pauseButton.state == 'hoveredPlayOff'){
            pauseButton.state = 'hoveredPlayOn'
            playGlob.playClicked()
                            socket.sendTextMessage('{ "Message": "Play" }');
        } else if(pauseButton.state == 'hoveredPlayOn'){
            pauseButton.state = 'hoveredPlayOff'
            playGlob.playClicked()
                            socket.sendTextMessage('{ "Message": "Pause" }');
        }
        else if (pauseButton.state === 'disabledPause'){
            pauseButton.state = 'disabledPause'
        }
}


contentItem:    Image{
id:pauseButton
sourceSize.width: 30
sourceSize.height: 30
source: "Icons/connection.svg"
clip: true

states: [
    State {
        name: "play_off"
        PropertyChanges { target: pauseButton; source: "Icons/play_off.svg" }
    },
    State {
        name: "pause_on"
        PropertyChanges { target: pauseButton; source: "Icons/pause_on.svg" }
    },
    State {
        name: "hoveredPlayOff"
        PropertyChanges{ target: pauseButton; source: "Icons/play_hover"}
    },
    State {
        name: "hoveredPlayOn"
        PropertyChanges{target: pauseButton; source: "Icons/pause_hover"}
    },
    State {
        name: "disabledPause"
        PropertyChanges {target: pauseButton; source: "Icons/pause_disabled.svg"}
    }

]
}
background: Rectangle{
id: zone
color:"#202020"
}
}
