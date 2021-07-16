import QtQuick 2.12
import QtQuick.Controls 1.4 as QQC
import QtQuick.Controls 2.15 as QQ
import QtQuick.Layouts 1.0

QQC.SplitView{
    orientation: Qt.Horizontal
    property alias textArea:textArea
    property alias musicPlayer:musicPlayer

    Layout.preferredWidth: appwindow.width
    Layout.preferredHeight: appwindow.height
    QQC.TextArea{
        id:textArea
        focus: true
        implicitWidth: 440
        Layout.preferredHeight: appwindow.height
        Layout.minimumWidth: 200
        Layout.maximumWidth: appwindow.width

        selectByKeyboard: true   //让文本中的内容可以被鼠标选中
        textFormat: TextEdit.AutoText         //AutoText the text edit will automatically determine whether                                                       //the text should be treated as rich textS
        onTextChanged: {
            if(text.length !== 0)
                flag = true;
        }
        MouseArea{
            id:mouseArea
            acceptedButtons: Qt.RightButton   //点击右键，content 响应右键的上下文菜单
            anchors.fill: textArea
            onClicked: {
                if(mouse.button==Qt.RightButton) {
                    mX=mouseX
                    mY=mouseY
                    menu1.open()
                }
            }
        }
        TapHandler{
            acceptedButtons: Qt.LeftButton  //点击左键，content 响应左键，右键的mousearea 关闭
            onTapped: {
                mouseArea.enabled=false;
            }
        }

        QQ.Menu{
            id:menu1
            x:mX
            y:mY
            contentData: [
                actions.copyAction,
                actions.pasteAction,
                actions.cutAction,
                actions.undoAction,
                actions.redoAction
            ]
        }
    }

    MusicPlayer{
        id:musicPlayer
        width: appwindow.width-textArea.width
        height: appwindow.height
        Timer{
            id:time
            interval: 10
            repeat: true
            running: false
            onTriggered: {
                var value=musicPlayer.audio.position;
                setTime(value);
            }
        }
        onStart: {
            time.running=true
            var path=new String(dialogs.fileMusicDialog.fileUrl);
            decode(path.slice(7));
            wave.show();
        }
        onStop:{
            time.running=false;
            actions.addTagAction.text="加入标签[00:00:00]";
            timerTest.running=false;
            wave.close();
        }
        onPause: {
            time.running=false;
            wave.close();
        }
    }
}
