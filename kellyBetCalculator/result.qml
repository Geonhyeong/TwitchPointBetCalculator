import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0

Item {
    width: 300
    height: 480
    Material.theme: Material.Dark

    Rectangle {
        id: rectangle
        color: "#9fa8da"
        anchors.fill: parent

        Column {
            id: column
            anchors.fill: parent
            anchors.topMargin: 0

            Row {
                id: row1
                width: 300
                height: 40
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 40
                spacing: 5

                Text {
                    width: 200
                    color: "#ffe082"
                    text: qsTr("결과 집계중...")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.italic: true
                    font.family: "Helvetica"
                    font.bold: true
                }

            }

            Row {
                id: row2
                width: 300
                height: 300
                anchors.top: row1.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: rectangle1
                    height: 280
                    color: "#818ecb"
                    radius: 15
                    border.color: "#00ffffff"
                    border.width: 0
                    anchors.fill: parent
                    anchors.rightMargin: 30
                    anchors.leftMargin: 30

                    Column {
                        id: colA
                        x: 40
                        width: 60
                        anchors.right: indicator.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 20
                        anchors.topMargin: 20
                        anchors.rightMargin: 10
                        spacing: 30

                        Text {
                            id: text1
                            color: "#3F51B5"
                            text: qsTr("A")
                            anchors.top: parent.top
                            font.pixelSize: 50
                            font.bold: true
                            font.italic: false
                            anchors.topMargin: 30
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        TextField {
                            id: aAlloc
                            width: parent.width
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            placeholderTextColor: "#ffe082"
                            anchors.horizontalCenter: parent.horizontalCenter
                            placeholderText: qsTr("")

                            Material.accent: "#3F51B5"
                        }

                        Button {
                            id: aButton
                            text: qsTr("Button")
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 25
                            highlighted: true
                            display: AbstractButton.IconOnly
                            enabled: aAlloc.text ? (bAlloc.text ? true : false) : false
                            anchors.horizontalCenter: parent.horizontalCenter
                            icon.source: "images/twitch.png"

                            contentItem: Item{
                                Image {
                                    source: aButton.icon.source
                                    width: 24
                                    height: 24
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                            Material.accent: "#3F51B5"

                            onClicked: {
                                Excel.readFile(fileName)
                                Excel.calcData(fileName, "A", aAlloc.text, bAlloc.text)
                                Excel.readFile(fileName)
                                stackView.pop()
                                stackView.push(Qt.resolvedUrl("qrc:/bet.qml"))
                            }
                        }

                    }

                    Column {
                        id: indicator
                        x: 120
                        width: 60
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 20
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            id: text7
                            width: 47
                            height: 50
                            color: "#ffffff"
                            text: qsTr("")
                            font.pixelSize: 32
                            verticalAlignment: Text.AlignVCenter
                            font.italic: true
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            id: text8
                            color: "#ffe082"
                            text: qsTr("배당률")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            font.italic: true
                            font.family: "Helvetica"
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            id: text9
                            color: "#ffe082"
                            text: qsTr("WIN")
                            anchors.bottom: parent.bottom
                            font.pixelSize: 12
                            anchors.bottomMargin: 40
                            font.italic: true
                            font.family: "Helvetica"
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        spacing: 30
                    }

                    Column {
                        id: colB
                        x: 200
                        width: 60
                        anchors.left: indicator.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 20
                        anchors.topMargin: 20
                        anchors.leftMargin: 10
                        spacing: 10
                        Text {
                            id: text4
                            color: "#f48fb1"
                            text: qsTr("B")
                            anchors.top: parent.top
                            font.pixelSize: 50
                            font.bold: true
                            font.italic: false
                            anchors.topMargin: 30
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        TextField {
                            id: bAlloc
                            width: 60
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            placeholderTextColor: "#ffe082"
                            anchors.horizontalCenter: parent.horizontalCenter
                            placeholderText: qsTr("")

                            Material.accent: Material.Pink
                        }

                        Button {
                            id: bButton
                            text: qsTr("Button")
                            anchors.bottom: parent.bottom
                            enabled: aAlloc.text ? (bAlloc.text ? true : false) : false
                            anchors.bottomMargin: 25
                            anchors.horizontalCenter: parent.horizontalCenter
                            display: AbstractButton.IconOnly
                            highlighted: true
                            icon.source: "images/twitch.png"

                            contentItem: Item {
                                Image {
                                    source: bButton.icon.source
                                    width: 24
                                    height: 24
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }

                            Material.accent: Material.Pink

                            onClicked: {
                                Excel.readFile(fileName)
                                Excel.calcData(fileName, "B", aAlloc.text, bAlloc.text)
                                Excel.readFile(fileName)
                                stackView.pop()
                                stackView.push(Qt.resolvedUrl("qrc:/bet.qml"))
                            }
                        }

                    }
                }



            }

            Button {
                id: skipButton
                width: 80
                height: 30
                text: qsTr("모르겠어요")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                font.wordSpacing: 0.1
                padding: 6
                font.pointSize: 6
                anchors.horizontalCenter: parent.horizontalCenter
                flat: true
                font.family: "Helvetica"
                font.underline: true

                contentItem: Item {
                    Text {
                        text: skipButton.text
                        font: skipButton.font
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                onClicked: {
                    Excel.readFile(fileName)
                    stackView.pop()
                    stackView.push(Qt.resolvedUrl("qrc:/bet.qml"))
                }
            }

        }
    }

}


