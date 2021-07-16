import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
ApplicationWindow{
    id:toolBarWindow
    width: 600
    height: 400

    property alias pop1:pop1
    property alias pop2:pop2
    Item{
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
                        Menu{
                            id:pop1
                            visible: true
                            width: 200
                            height: 300
                            modal: true
                            focus: true
                            contentData: [
                                actions.openAction,
                                actions.saveAction,
                                actions.newAction
                            ]
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
                        Menu{
                            id:pop2
                            visible: true
                            width: 200
                            height: 300
                            modal: true
                            focus: true
                            contentData: [
                                actions.openAction,
                                actions.saveAction,
                                actions.newAction
                            ]
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


}


