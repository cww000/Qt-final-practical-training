import QtQuick 2.12
import QtQuick.Controls 1.4 as QQC
import QtQuick.Controls 2.15 as QQ
import QtQuick.Layouts 1.0


QQC.SplitView {
    orientation: Qt.Horizontal
    property alias lableContent:labelContet
    property alias catalogue:catalogue
    Layout.fillHeight: true
    Layout.fillWidth: true
    Rectangle{
        id:catalogue
        implicitWidth: 440
        Layout.preferredHeight: appwindow.height
        Layout.maximumWidth: parent.width
    }

    QQ.ScrollView{
        QQ.ScrollBar.vertical.policy: QQ.ScrollBar.AlwaysOn
        QQ.ScrollBar.horizontal.policy: QQ.ScrollBar.AlwaysOff
        width: appwindow.width-catalogue.width
        height: maximumHeight
//        contentWidth: appwindow.width-textArea.width
//        contentHeight: appwindow.height
        Rectangle{
            id:kid
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.fill: parent
            border.width: 1
            border.color: "grey"
            MyLabel{
                id:labelContet
                anchors.centerIn: parent
                anchors.margins: 10
            }
        }
    }
}
