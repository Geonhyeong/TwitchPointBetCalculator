import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.0
import "."

Window {
//    property bool mbImageClicked: true
//    property int mCount: 0
    property string fileName
    id: idWindow
    visible: true
    width: 300
    height: 480
    title: qsTr("포인트 쏙쏙 빼줌마")

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        initialItem: Item {
            id: mainContent
            Rectangle{
                id: rectangle
                color: "#9FA8DA"
                anchors.fill: parent

                Image {
                    id: twitch
                    x: 100
                    y: 50
                    width: 100
                    anchors.top: parent.top
                    source: "images/twitch.png"
                    anchors.topMargin: 80
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
                }

                Column {
                    id: column
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 25
                    width: 150
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 100

                    Button {
                        id : createButton
                        text: qsTr("새로 만들기")
                        highlighted: true
                        flat: false
                        anchors.horizontalCenter: parent.horizontalCenter
                        icon.source: "images/add.png"
                        font.family: "Helvetica"
                        font.bold: true
                        antialiasing: true
                        width: parent.width

                        Material.accent: Material.DeepPurple

                        contentItem: Item{
                            id: item1
                            Row{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 10
                                Image {
                                    width: 15
                                    height: 15
                                    source: createButton.icon.source
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text {
                                    color: "#ffffff"
                                    text: createButton.text
                                    font: createButton.font
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }

                        onClicked: {
                            stackView.push(Qt.resolvedUrl("qrc:/create.qml"))
                        }
                    }

                    Button {
                        id : loadButton
                        text: qsTr("불러오기")
                        highlighted: true
                        flat: false
                        icon.source: "images/load.png"
                        font.family: "Helvetica"
                        font.bold: true
                        antialiasing: true
                        width: parent.width

                        Material.accent: Material.DeepPurple

                        contentItem: Item{
                            id: item2
                            Row{
                                id: row
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 10
                                Image {
                                    width: 15
                                    height: 15
                                    source: loadButton.icon.source
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text {
                                    color: "#ffffff"
                                    text: loadButton.text
                                    font: loadButton.font
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }

                        onClicked: {
                            fileDialog.open()
                        }
                    }
                }


            }
        }


    }

    FileDialog
    {
        id: fileDialog
        title: "Please choose a file"
        folder: "../build-kellyBetCalculator-Desktop_Qt_5_15_2_MinGW_64_bit-Debug/databases/"
        onAccepted: {
            var path = fileDialog.fileUrl.toString();
            fileName = "databases/" + path.slice(path.lastIndexOf("/")+1)
            Excel.readFile(fileName)
            stackView.push(Qt.resolvedUrl("qrc:/bet.qml"))
            fileDialog.close()
        }
        onRejected: {
            fileDialog.close()
        }
        //Component.onCompleted: visible = true
        nameFilters: ["excel files (*.xlsx)"]
        sidebarVisible: false
    }

}

//function basename(str)
//{
//    return (str.slice(str.lastIndexOf("/")+1))
//}
