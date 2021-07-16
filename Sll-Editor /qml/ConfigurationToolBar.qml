import QtQuick 2.12
import QtQuick.Controls 2.12
ApplicationWindow{
    id:toolBarWindow
    width: 600
    height: 400
    property alias acceptButton:configuration.acceptButton
    property alias recRight:configuration.recRight
    property alias recLeft:configuration.recLeft
    property alias listView:configuration.listView
    property alias listViewRight:configuration.listViewRight
    property alias buttonLeft:configuration.buttonLeft
    property alias buttonRight:configuration.buttonRight
    property alias buttonTop:configuration.buttonTop
    property alias buttonBottom:configuration.buttonBottom

    ConfigurationToolBarForm{
        id:configuration
        anchors.centerIn: parent
        cancelButton.onClicked: toolBarWindow.visible=false


    }


}

