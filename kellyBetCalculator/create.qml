import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0

Item {
    width: 300
    height: 480
    Rectangle//배경 색을 지정하는 부분
    {
        id: rectangle
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        color:"#9FA8DA"


        Image {
            id: twitch
            x: 110
            y: 45
            width: 80
            source: "images/twitch.png"
            fillMode: Image.PreserveAspectFit
        }

        Column {
            id: column
            spacing: 10
            width: 150
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                id: titleRow
                anchors.right: parent.right
                anchors.rightMargin: -40
                spacing: 10

                Text {
                    color: "#ffffff"
                    text: qsTr("제목 :")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    font.family: "Helvetica"
                    font.pointSize: 10
                    font.bold: true
                }

                TextField {
                    id: title
                    width: 150
                    height: 35
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignLeft
                    placeholderTextColor: "#7fffffff"
                    leftPadding: 6
                    padding: 10
                    bottomPadding: 10
                    topPadding: 10
                    hoverEnabled: true
                    placeholderText: qsTr("title")
                }
            }

            Row {
                id: currentPointRow
                anchors.right: parent.right
                anchors.rightMargin: -40
                spacing: 10

                Text {
                    color: "#ffffff"
                    text: qsTr("현재 포인트 :")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                    font.family: "Helvetica"
                    font.pointSize: 10
                    font.bold: true
                }

                TextField {
                    id: currentPoint
                    width: 150
                    height: 35
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignLeft
                    placeholderTextColor: "#7fffffff"
                    leftPadding: 6
                    padding: 10
                    bottomPadding: 10
                    topPadding: 10
                    hoverEnabled: true
                    placeholderText: qsTr("current point")
                    validator: IntValidator {}
                }
            }

            Row {
                id: allocationRateRow
                visible: true
                anchors.right: parent.right
                anchors.rightMargin: -40
                spacing: 10

                Text {
                    color: "#ffffff"
                    text: qsTr("A 승 :")
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "Helvetica"
                    font.pointSize: 10
                    font.bold: true
                }

                TextField {
                    id: aWinCount
                    width: 150
                    height: 35
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignLeft
                    placeholderTextColor: "#7fffffff"
                    leftPadding: 6
                    padding: 10
                    bottomPadding: 10
                    topPadding: 10
                    hoverEnabled: true
                    placeholderText: qsTr("win count")
                    validator: IntValidator {}
                }
            }

            Row {
                id: winRateRow
                visible: true
                anchors.right: parent.right
                spacing: 10
                anchors.rightMargin: -40
                Text {
                    id: text1
                    color: "#ffffff"
                    text: qsTr("B 승 :")
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "Helvetica"
                    font.bold: true
                    font.pointSize: 10
                }

                TextField {
                    id: bWinCount
                    width: 150
                    height: 35
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignLeft
                    placeholderTextColor: "#7fffffff"
                    bottomPadding: 10
                    placeholderText: qsTr("win count")
                    hoverEnabled: true
                    leftPadding: 6
                    topPadding: 10
                    padding: 10
                    validator: IntValidator {}
                }
            }

        }
    }

    Button {
        id : submitButton
        text: qsTr("Submit")
        anchors.bottom: parent.bottom
        enabled: title.text ? (currentPoint.text ? (aWinCount.text ? (bWinCount.text ? true : false) : false) : false) : false
        anchors.bottomMargin: 60
        highlighted: true
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Helvetica"
        font.bold: true
        antialiasing: true
        width: 120
        opacity: 0.8

        Material.accent: Material.DeepPurple

        contentItem: Item{
            Text {
                color: "#ffffff"
                text: "Create!"
                font: submitButton.font
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        onClicked: {
            fileName = "databases/" + title.text + ".xlsx";
            Excel.createFile(fileName, currentPoint.text, aWinCount.text, bWinCount.text);
            Excel.readFile(fileName);
            stackView.push(Qt.resolvedUrl("qrc:/bet.qml"))
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
