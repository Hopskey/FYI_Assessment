import QtQuick 2.15
import QtQuick.Window 2.1
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Layouts


Window {
    property int default_pix_density: 4  //pixel density of my current screen
    property int scale_factor: Screen.pixelDensity/default_pix_density

    visible: true
    width: 1280
    height: 720
    title: "Video Player"
    color: "black"


    FileDialog {
        id: fileDialog
        title: "Please choose a video"
        nameFilters: ["Video files (*.mp4 *.avi)"]
        onAccepted: {
                video.source = fileDialog.currentFile;
                video.play()
        }
    }


    Video {
        id: video
        width : parent.width
        height : parent.height


    }

    Rectangle{

        id: options
        width: parent.width
        height: 30
        anchors.bottom:  sliderBase.top
        color: "lightgrey"
        border.color:"black"

        MouseArea {
            id: loadButton
            width: 100
            height: 30
            onClicked: fileDialog.open()


            Rectangle {
                anchors.fill: parent
                color: "lightgrey"
                border.color:"black"
                Text {
                    text: "Choose Video"
                    anchors.centerIn: parent
                }
            }
        }

        MouseArea {
            id: playButton
            width: 50
            height: 20
            x: (parent.width / 2) - 40
            onClicked: video.play()

            Rectangle {
                 height: 20
                id: rectplay
                anchors.fill: parent
                color: "lightgrey"

//                Text {
//                    text: "Play"
//                    anchors.centerIn: parent
//                }
                Image {
                    height: 30
                    width:50
                    id: play
                    source: "qrc:///play.png"
//                    fillMode: rectplay

                }
            }
        }

        MouseArea {
            id: pauseButton
            width: 50
            height: 20
            x: (parent.width / 2) + 40

            onClicked: video.pause()

            Rectangle {
                anchors.fill: parent
                color: "lightgrey"
                height: 20

//                Text {
//                    text: "Pause"
//                    anchors.centerIn: parent
//                }
                Image {
                    height: 30
                    width:50
                    id:pause
                    source: "qrc:///pause.png"
                }
            }
        }

    }



    // Custom Slider
    Rectangle {
        id: sliderBase
        width: parent.width
        height: 20
        anchors.bottom: parent.bottom
        color: "lightgray"
        border.color:"black"

        Rectangle {
            id: sliderHandle
            width: sliderBase.width * (video.position / video.duration)
            height: sliderBase.height
            color: "blue"
        }

        MouseArea {
            id: sliderArea
            anchors.fill: parent
            onPressed: video.pause()
            onPositionChanged: {
                let seekPosition = video.duration * (mouse.x / width)
                video.position = seekPosition
                sliderHandle.width = sliderBase.width * (video.position / video.duration)
            }
            onReleased: video.play()
        }
    }
}
