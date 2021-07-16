import QtQuick 2.12
import QtQuick.Controls 2.5
Item {
    property alias newAction: newA
    property alias openAction: openLyric
    property alias openMusicAction:openMusic
    property alias saveAction: save
    property alias saveMusicAction: saveMusic
    property alias closeAction: close
    property alias exitAction: exit
    property alias copyAction: copy
    property alias pasteAction: paste
    property alias cutAction: cut
    property alias undoAction: undo
    property alias redoAction: redo
    property alias changeFontAction: changeFont
    property alias configurationToolbarAction: configurationToolbar
    property alias showToolBarAction: showToolBar
    property alias showStatusBarAction: showStatusBar
    property alias aboutAction: about
    property alias addTagAction: addTag
    property alias deleteHeaderLabelAction:deleteHeaderLabel
    property alias deleteAllLabelAction:deleteAllLabel
    property alias testCurrentLyricAction:testCurrentLyric
    property alias testAction: test
    property alias fastForwardAction: fastForward
    property alias goBackAction: goBack
    property alias listModel:listModel
    property alias listModelRight:listModelRight
    property alias textDelegate:textDelegate
    property alias textDelegateRight:textDelegateRight

    property var listTotal:new Array
    property int num:0

    property var str:new Array   //从右到左
    property var str1;
    property  var w:0

    property var str2:new Array
    property var str3;   //从左到右
    property  var w1:0

    ListModel{
        id:listModel
    }

    ListModel{
        id:listModelRight
    }


    Component{
        id:textDelegate
        Text {
            id: text1
            text: portrait
            width: 200
            focus: true
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    str2[w1]=text
                    str3=text
                    w1++
                    dialogs.configurationDialog.listView.currentIndex=index;

              //      console.log(str)
                }
            }

          //  color: wrapper.ListView.isCurrentItem ? "red" : "black"
            HoverHandler{
                onHoveredChanged: {
                    if(hovered) {
                        dialogs.configurationDialog.listView.currentIndex=index
                    }
                }
            }
        }
    }

    Component{
        id:textDelegateRight
        Text {
            id: text2
            text: portrait
            width: 200
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    str[w]=text
                    str1=text
                    w++
                    dialogs.configurationDialog.listView.currentIndex=index;

              //      console.log(str)
                }
            }
          //  color: wrapper.ListView.isCurrentItem ? "red" : "black"
            HoverHandler{
               onHoveredChanged: {
                  if(hovered) {
                     dialogs.configurationDialog.listViewRight.currentIndex=index

                  }
               }
            }
        }
    }
    Action{
       id:newA
       property bool flag:false
       text: qsTr("新建")

       shortcut: StandardKey.New
       icon.name: "document-new"
       Component.onCompleted: {
          listTotal[num]=text;
          num+=1;
           for(var i=0;i<22;i++) {
               listModel.append({"portrait":listTotal[i]});
           }

       }
    }


    Action{
        id:openLyric
        property bool flag:false
        text: qsTr("打开歌词文件")
        shortcut: StandardKey.Open
        icon.name:"document-open"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:openMusic
        property bool flag:false
        text: qsTr("打开音频文件")
   //     shortcut: StandardKey.Open
        icon.name:"document-open"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:save
        property bool flag:false
        text: qsTr("保存")
        shortcut: StandardKey.Save
        icon.name: "document-save"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:saveMusic
        property bool flag:false
        text: qsTr("保存音频文件")
     //   shortcut: StandardKey.Save
        icon.name: "document-save"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:close
        property bool flag:false
        text: qsTr("关闭")
       shortcut: StandardKey.Close
       icon.name: "document-close"
       enabled: content.textArea.text.length === 0 ? false : true
       Component.onCompleted: {
           listTotal[num]=text;
          num+=1;
       }
    }
    Action{
        id:exit
        property bool flag:false
        text: qsTr("退出")
        shortcut: StandardKey.Quit
        icon.name:"application-exit"
        Component.onCompleted: {
            listTotal[num]=text;
           num+=1;
        }

    }
    Action{
        id:copy
        property bool flag:false
        text: qsTr("复制")
        shortcut: StandardKey.Copy
        icon.name: "edit-copy"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:paste
        property bool flag:false
        text: qsTr("粘贴")
        shortcut: StandardKey.Paste
        icon.name: "edit-paste"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }

    }
    Action{
        id:cut
        property bool flag:false
        text: qsTr("剪切")
        shortcut: StandardKey.Cut
        icon.name: "edit-cut"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:undo
        property bool flag:false
        text:qsTr("撤销")
        shortcut: StandardKey.Undo
        icon.name: "edit-undo"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }

    Action{
        id:redo
        property bool flag:false
        text:qsTr("重做")
        shortcut: StandardKey.Redo
        icon.name: "edit-redo"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }


    Action{
        id:addTag
        property bool flag:false
        text: qsTr("加入标签[00:00.00]")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:deleteHeaderLabel
        property bool flag:false
        text: qsTr("删除行内首标签")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:deleteAllLabel
        property bool flag:false
        text: qsTr("删除行内所有标签")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:changeFont
        property bool flag:false
        text: qsTr("更改字体")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }

    Action{
        id:configurationToolbar
        property bool flag:false
        text: qsTr("配置工具栏")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }

    CheckBox {
        id:showToolBar
        property bool flag:false
        checked: true
        text: qsTr("显示工具栏")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }

    CheckBox{
        id:showStatusBar
        property bool flag:false
        checked: true
        text: qsTr("显示状态栏")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }

    Action{
        id:testCurrentLyric
        property bool flag:false
        text: qsTr("测试当前歌词")
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:test
        property bool flag:false
        text: qsTr("测试")
         enabled: content.musicPlayer.fileName!==" "
         icon.name: "media-record"
         Component.onCompleted: {
             listTotal[num]=text;
            num+=1;
         }
    }
    Action{
        id:fastForward
        property bool flag:false
        text: qsTr("快进5秒")
        enabled: content.musicPlayer.fileName!==" "
        icon.name: "media-skip-forward"
        Component.onCompleted: {
           listTotal[num]=text;
           num+=1;
        }
    }
    Action{
        id:goBack
        property bool flag:false
        text: qsTr("快退5秒")
         enabled: content.musicPlayer.fileName!==" "
         icon.name: "media-skip-backward"
         Component.onCompleted: {
            listTotal[num]=text;
            num+=1;
         }
    }
    Action{
        id:about
        property bool flag:false
        text: qsTr("关于")
        icon.name: "help-about"
        Component.onCompleted: {
          listTotal[num]=text;
           num+=1;
        }
    }
}
