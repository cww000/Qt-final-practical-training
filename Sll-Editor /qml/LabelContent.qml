import QtQuick.Layouts 1.0
import QtQuick.Controls 2.15
import QtQuick 2.15
Rectangle{
 //   anchors.fill: parent
    id:rec
    width: 300
    height: 200
    property alias titleInput:titleInput
    property alias artistInput:artistInput
    property alias albumInput:albumInput
    property alias commentInput:commentInput
    property alias dateInput:dateInput
    property alias trackNumberInput:trackNumberInput
    property alias genreInput:genreInput
    ColumnLayout{
        spacing: 0
        RowLayout{
            id:rowLayout1
            spacing:0
            Rectangle {
                id:rec1
              //  width: 90
                Layout.preferredWidth: 105
                Layout.preferredHeight:rec.height/7
                border.color: "grey"
                RowLayout{
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    CheckBox{
                        id:title
                        checked: true
                     //   text:qsTr("标题")
                //        anchors.centerIn: parent

                    }
                    Text {
                        id: titleText
                        text: qsTr("标题")
                    }
                }
                TapHandler{
                 //   anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec1.color="skyblue"
                        rec2.color="white"
                        rec3.color="white"
                        rec4.color="white"
                        rec5.color="white"
                        rec6.color="white"
                        rec7.color="white"
                    }
                }
            }
            TextField{
                id:titleInput
                Layout.fillWidth: true
                Layout.preferredWidth: rec.width-rec1.width
                Layout.preferredHeight: rec.height/7
                TapHandler{
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec1.color="white"
                    }
                }

            }
       }
        RowLayout{
            spacing: 0
            Rectangle{
                id:rec2
                Layout.preferredWidth: 105
                Layout.preferredHeight:rec.height/7
                border.color: "grey"
                RowLayout{
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    CheckBox{
                        id:artist
                        checked: true
                    //    text: qsTr("艺人")
                    }
                    Text {
                        id: artistText
                        text: qsTr("艺人")
                    }
                }
                TapHandler{
                 //   anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec2.color="skyblue"
                        rec1.color="white"
                        rec3.color="white"
                        rec4.color="white"
                        rec5.color="white"
                        rec6.color="white"
                        rec7.color="white"
                    }
                }
            }
            TextField{
                id:artistInput
                Layout.fillWidth: true
                Layout.preferredWidth: rec.width-rec2.width
                Layout.preferredHeight: rec.height/7
                TapHandler{
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec2.color="white"
                    }
                }
            }
        }
        RowLayout{
            spacing: 0
            Rectangle{
                id:rec3
                Layout.preferredWidth: 105
                Layout.preferredHeight:rec.height/7
                border.color: "grey"
                RowLayout{
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    CheckBox{
                        id:album
                        checked: true
                    }
                    Text {
                        id: albumText
                        text: qsTr("专辑")
                    }
                }
                TapHandler{
                 //   anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec3.color="skyblue"
                        rec2.color="white"
                        rec1.color="white"
                        rec4.color="white"
                        rec5.color="white"
                        rec6.color="white"
                        rec7.color="white"
                    }
                }
            }
            TextField{
                id:albumInput
                Layout.fillWidth: true
                Layout.preferredWidth: rec.width-rec3.width
                Layout.preferredHeight: rec.height/7
                TapHandler{
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec3.color="white"
                    }
                }

            }
        }
        RowLayout{
            spacing: 0
            Rectangle{
                id:rec4
                Layout.preferredWidth: 105
                Layout.preferredHeight:rec.height/7
                border.color: "grey"
                RowLayout{
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    CheckBox{
                        id:annotation
                        checked: true
                    }
                    Text {
                        id: commentText
                        text: qsTr("注释")
                    }
                }
                TapHandler{
                 //   anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec4.color="skyblue"
                        rec2.color="white"
                        rec3.color="white"
                        rec1.color="white"
                        rec5.color="white"
                        rec6.color="white"
                        rec7.color="white"
                    }
                }
            }
            TextField{
                id:commentInput
                Layout.fillWidth: true
                Layout.preferredWidth: rec.width-rec4.width
                Layout.preferredHeight: rec.height/7
                TapHandler{
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec4.color="white"
                    }
                }

            }
        }
        RowLayout{
            spacing: 0
            Rectangle{
                id:rec5
                Layout.preferredWidth: 105
                Layout.preferredHeight:rec.height/7
                border.color: "grey"
                RowLayout{
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    CheckBox{
                        id:date
                        checked: true
                    }
                    Text {
                        id: dateText
                        text: qsTr("日期")
                    }
                }
                TapHandler{
                 //   anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec5.color="skyblue"
                        rec7.color="white"
                        rec2.color="white"
                        rec3.color="white"
                        rec4.color="white"
                        rec1.color="white"
                        rec6.color="white"
                    }
                }
            }
            TextField{
                id:dateInput
                Layout.fillWidth: true
                Layout.preferredWidth: rec.width-rec5.width
                Layout.preferredHeight: rec.height/7
                TapHandler{
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec5.color="white"
                    }
                }

            }
        }
        RowLayout{
            spacing: 0
            Rectangle{
                id:rec6
                Layout.preferredWidth: 105
                Layout.preferredHeight:rec.height/7
                border.color: "grey"
                RowLayout{
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    CheckBox{
                        id:trackNumber
                        checked: true
                    }
                    Text {
                        id: trackNumberText
                        text: qsTr("音轨编号")
                    }
                }
                TapHandler{
                 //   anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec6.color="skyblue"
                        rec7.color="white"
                        rec2.color="white"
                        rec3.color="white"
                        rec4.color="white"
                        rec5.color="white"
                        rec1.color="white"
                    }
                }
            }
            TextField{
                id:trackNumberInput
                Layout.fillWidth: true
                Layout.preferredWidth: rec.width-rec6.width
                Layout.preferredHeight: rec.height/7
                TapHandler{
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec6.color="white"
                    }
                }

            }
        }
        RowLayout{
            spacing: 0
            Rectangle{
                id:rec7
                Layout.preferredWidth: 105
                Layout.preferredHeight:rec.height/7
                border.color: "grey"
                RowLayout{
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    CheckBox{
                        id:genreNumber
                        checked: true
                    }
                    Text {
                        id: genreText
                        text: qsTr("流派")
                    }
                }
                TapHandler{
                 //   anchors.fill:parent
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        rec7.color="skyblue"
                        rec6.color="white"
                        rec2.color="white"
                        rec3.color="white"
                        rec4.color="white"
                        rec5.color="white"
                        rec1.color="white"
                    }
                }
            }
            ComboBox{
                id:genreInput
                editable: true
                Layout.fillWidth: true
                Layout.preferredWidth: rec.width-rec6.width
                Layout.preferredHeight: rec.height/7
                currentIndex: -1
            //    highlighted: Rectangle{color: "lightblue";width: genreInput.width}
                model:ListModel{
                    id:genreModel
                    ListElement{text:"Acousic"}
                    ListElement{text:"Abstract"}
                    ListElement{text:"A Cappella"}
                    ListElement{text:"Acid"}
                    ListElement{text :"Acid Jazz"}

                }

                TapHandler{
                    acceptedButtons: Qt.LeftButton
                    onTapped:  {
                        rec7.color="white"
                    }
                }

            }
        }
    }
}
