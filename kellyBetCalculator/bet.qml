import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0

Item {
    width: 300
    height: 480

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
                    id: currentPointText
                    color: "#ffffff"
                    text: qsTr("현재 포인트 : ")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.pixelSize: 10
                    font.family: "Helvetica"
                    font.bold: true
                    anchors.leftMargin: 50
                }

                Text {
                    id: currentPoint
                    visible: true
                    color: "#ffffff"
                    text: Excel.getPoint()
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: currentPointText.right
                    anchors.right: ptsText.left
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    anchors.rightMargin: 50
                    anchors.leftMargin: 50
                    font.bold: true
                    font.family: "Helvetica"
                }

                TextField {
                    id: editPoint
                    width: 100
                    visible: false
                    color: "#ffffff"
                    text: currentPoint.text
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: currentPointText.right
                    anchors.right: ptsText.left
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    enabled: true
                    font.bold: true
                    font.family: "Helvetica"
                }

                Text {
                    id: ptsText
                    color: "#ffffff"
                    text: qsTr("pts")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: editButton.left
                    font.pixelSize: 10
                    anchors.rightMargin: 10
                    font.bold: true
                    font.family: "Helvetica"
                }

                Button {
                    id: editButton
                    width: 35
                    height: 35
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    display: AbstractButton.IconOnly
                    anchors.rightMargin: 20
                    flat: true
                    icon.source: "images/edit.png"

                    contentItem: Item {
                        id: item1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            source: editButton.icon.source
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 15
                            height: 15
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    onClicked: {
                        if (currentPoint.visible)
                        {
                            currentPoint.visible = false
                            editPoint.visible = true
                            editPoint.text = currentPoint.text
                        }
                        else
                        {
                            editPoint.visible =false
                            currentPoint.visible = true
                            if(editPoint.text != "")
                            {
                                currentPoint.text = editPoint.text
                                Excel.editPoint(fileName, currentPoint.text);
                            }
                        }
                    }
                }

            }

            Row {
                id: row2
                width: 300
                height: 180
                anchors.top: row1.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: rectangle1
                    height: parent.height
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
                        height: 100
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: indicator.left
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        anchors.rightMargin: 20
                        spacing: 10

                        Text {
                            id: text1
                            color: "#3f51b5"
                            text: qsTr("A")
                            font.pixelSize: 50
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        TextField {
                            id: aAllocationRate
                            width: 60
                            height: 40
                            color: "#3f51b5"
                            placeholderText: qsTr("A 배당률")
                            hoverEnabled: true
                            validator: DoubleValidator {}
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                            Material.accent: Material.Indigo
                        }

                        Text {
                            id: aWinRate
                            color: "#3f51b5"
                            text: Excel.getAWin() + "%"
                            font.pixelSize: 16
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Column {
                        id: indicator
                        x: 120
                        width: 60
                        height: 100
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        Item {
                            id: item2
                            width: 50
                            height: 50
                            anchors.horizontalCenter: parent.horizontalCenter

                            Button {
                                id: betButton
                                text: qsTr("Bet")
                                anchors.fill: parent
                                font.pixelSize: 11
                                highlighted: true
                                font.family: "Helvetica"
                                font.bold: true
                                font.italic: false
                                display: AbstractButton.TextOnly
                                anchors.rightMargin: 5
                                anchors.leftMargin: 5
                                anchors.bottomMargin: 5
                                anchors.topMargin: 5
                                enabled: aAllocationRate.text ? (bAllocationRate.text ? true : false) : false
                                Material.accent: Material.DeepOrange

                                onClicked: {
                                    Excel.setBet(fileName, aAllocationRate.text, bAllocationRate.text)
                                    betTeam.text = Excel.getBetTeam()
                                    betPoint.text = Excel.getBetPoint()
                                    okButton.enabled = true;
                                }
                            }
                        }

                        Text {
                            id: text8
                            color: "#ffffff"
                            text: qsTr("배당률")
                            anchors.top: item2.bottom
                            font.pixelSize: 12
                            anchors.topMargin: 25
                            font.family: "Helvetica"
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            id: text9
                            color: "#ffffff"
                            text: qsTr("승률")
                            anchors.bottom: parent.bottom
                            font.pixelSize: 12
                            anchors.bottomMargin: 0
                            font.family: "Helvetica"
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }


                        spacing: 10
                    }

                    Column {
                        id: colB
                        x: 200
                        width: 60
                        height: 100
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: indicator.right
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        anchors.leftMargin: 20
                        spacing: 10
                        Text {
                            id: text4
                            color: "#f48fb1"
                            text: qsTr("B")
                            font.pixelSize: 50
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        TextField {
                            id: bAllocationRate
                            width: 60
                            height: 40
                            color: "#f48fb1"
                            placeholderText: qsTr("B 배당률")
                            hoverEnabled: true
                            validator: DoubleValidator {}
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                            Material.accent: "#f48fb1"
                        }

                        Text {
                            id: bWinRate
                            color: "#f48fb1"
                            text: Excel.getBWin() + "%"
                            font.pixelSize: 16
                            font.family: "Helvetica"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }



            }

            Button {
                id: okButton
                height: 40
                text: qsTr("OK!")
                anchors.bottom: parent.bottom
                highlighted: true
                flat: false
                font.pointSize: 12
                font.family: "Helvetica"
                font.bold: true
                font.italic: true
                anchors.bottomMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: false
                Material.accent: Material.DeepPurple

                onClicked: {
                    stackView.pop()
                    stackView.push(Qt.resolvedUrl("qrc:/result.qml"))
                }
            }

            //            Button {
            //                id: skipButton
            //                width: 80
            //                height: 30
            //                text: qsTr("모르겠어요")
            //                anchors.top: okButton.bottom
            //                font.wordSpacing: 0.1
            //                padding: 6
            //                font.pointSize: 6
            //                anchors.topMargin: 0
            //                anchors.horizontalCenter: parent.horizontalCenter
            //                flat: true
            //                font.family: "Helvetica"
            //                font.underline: true

            //                contentItem: Item {
            //                    Text {
            //                        text: skipButton.text
            //                        font: skipButton.font
            //                        color: "#ffffff"
            //                        anchors.verticalCenter: parent.verticalCenter
            //                        anchors.horizontalCenter: parent.horizontalCenter
            //                    }
            //                }
            //            }

            Rectangle {
                id: rectangle2
                width: 200
                height: 100
                color: "#00ffffff"
                radius: 10
                border.color: "#ffe082"
                border.width: 2
                anchors.top: row2.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: rectangle3
                    x: 70
                    y: -27
                    width: 80
                    height: 40
                    color: "#9fa8da"
                    anchors.bottom: parent.verticalCenter
                    anchors.bottomMargin: 30
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: text2
                        color: "#ffe082"
                        text: qsTr("BET!")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Helvetica"
                        font.italic: true
                    }
                }


                Row {
                    width: 160
                    height: 60
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: betTeam
                        width: parent.width/3
                        height: parent.height
                        color: "#ffe082"
                        text: qsTr("X")
                        font.pixelSize: 40
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.italic: true
                    }

                    Text {
                        id: betPoint
                        width: parent.width/3*2
                        height: parent.height
                        color: "#ffe082"
                        text: qsTr("0")
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Helvetica"
                        font.italic: true
                    }
                }
            }

        }

        Button {
            id: previousButton
            width: 40
            height: 40
            anchors.left: parent.left
            anchors.top: parent.top
            flat: true
            anchors.topMargin: 0
            anchors.leftMargin: 0
            icon.source: "images/previous.png"

            contentItem: Item {
                Image {
                    source: previousButton.icon.source
                    width: 15
                    height: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            onClicked: {
                stackView.pop();
            }
        }
    }

}
