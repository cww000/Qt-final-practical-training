import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import QtQml.Models 2.15
Item {
    width: columLayout.implicitWidth
    height: columLayout.implicitHeight
    property alias cancelButton:cancelButton
    property alias acceptButton:acceptButton
    property alias recRight:recRight
    property alias recLeft:recLeft
    property alias listView:listView
    property alias listViewRight:listViewRight
    property alias buttonLeft:buttonLeft
    property alias buttonRight:buttonRight
    property alias buttonTop:buttonTop
    property alias buttonBottom:buttonBottom
    ColumnLayout {
        id:columLayout
        spacing: 20
        RowLayout {
            RowLayout {
                ColumnLayout {
                    Text {
                        id: textLeft
                        text: qsTr("可用操作")
                    }

                    Rectangle{
                        id:recLeft
                        width:200
                        height: 310
                        border.width: 2
                        border.color: "LightBlue"

                        ListView{
                            id:listView
                            focus: true
                            spacing: 5
                            currentIndex:-1
                            anchors.fill: parent

                            highlight: Rectangle{ color: "lightsteelblue";width: 200}
                            model:actions.listModel
                            delegate:actions.textDelegate
                        }

                    }
                }
                Button {
                    id: buttonLeft
                    text: qsTr("<")
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                }
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignCenter
                Button {
                    id: buttonTop
                    text: qsTr("^")
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    Layout.bottomMargin: 40
                }

                Button {
                    id: buttonBottom
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    text: qsTr("V")
                }
            }
            RowLayout {
                Button {
                    id: buttonRight
                    text: qsTr(">")
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                }

                ColumnLayout {
                    Text {
                        id: textRight
                        text: qsTr("当前操作")
                    }
                    Rectangle{
                        id:recRight
                        border.width: 2
                        border.color: "LightBlue"
                        width:200
                        height: 310
                        ListView{
                            id:listViewRight
                            focus: true
                            spacing: 5
                            currentIndex:-1
                            anchors.fill: parent

                            highlight: Rectangle{ color: "lightsteelblue";width: 200}
                            model:actions.listModelRight
                            delegate: actions.textDelegateRight
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 20
            Button {
                id: acceptButton
                text: qsTr("确认")
            }

            Button {
                id: cancelButton
                text: qsTr("取消")
            }
        }
    }

}
