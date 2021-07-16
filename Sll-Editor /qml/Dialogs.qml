import QtQuick 2.12
import QtQuick.Dialogs 1.3
Item {
    id:dialog
    property alias fileMusicDialog: fileMusicDialog
    property alias fileDialog:fileDialog
    property alias newDialog: newDialog
    property alias closeDialog: closeDialog
    property alias aboutDialog: aboutDialog
    property alias fontOpenDialog:fontOpenDialog
    property alias configurationDialog:configurationDialog

    function openAboutDialog(){aboutDialog.open()}
    function openNewDialog(){newDialog.open()}
    function openCloseDialog(){closeDialog.open()}
    function openFileDialog() {fileDialog.open()}

    function openFontDialog(){fontOpenDialog.open()}
    function openConfigurationDialog(){configurationDialog.visible=true;}

    function openMusicDialog() {
        fileMusicDialog.open()
    }

    FontDialog{
        id:fontOpenDialog
        title: "Please choose a font"
    }

    FileDialog{
        id:fileDialog
        title: "Please choose a file"
        folder:shortcuts.documents
        nameFilters: [ "Lrc Files(*.lrc *.txt)",
                        "*.*"]
        selectExisting: false
    }

    FileDialog{
        id:fileMusicDialog
        title: "Please choose a music file"
        folder:shortcuts.documents
        nameFilters: ["Audio Files(*.mp3 *.wav *.ogg *flac)"]
    }

    MessageDialog{
        id: newDialog
        title: qsTr("create a new text")
        text: qsTr("文档已被修改\n您想要保存还是忽略更改?\n")
        standardButtons: StandardButton.Save|StandardButton.Discard|StandardButton.Cancel
        onButtonClicked: {
            if(clickedButton === StandardButton.Save){
                actions.saveAction.trigger()
                if(fileDialog.selectExisting === true){
                    content.textArea.text = ""
                    fileDialog.selectExisting = false
                }
            }else if(clickedButton === StandardButton.Discard){
                content.textArea.text= ""
            }else{
                close()
            }
        }
    }

    MessageDialog{
        id: closeDialog
        title: qsTr("create a new text")
        text: qsTr("文档已被修改\n您想要保存还是忽略更改?\n")
        standardButtons: StandardButton.Save|StandardButton.Discard|StandardButton.Cancel
        onButtonClicked: {
            if(clickedButton === StandardButton.Save){
                actions.saveAction.trigger()
                if(dialogs.fileDialog.selectExisting === true){
                    content.textArea.text = ""
                    dialogs.fileDialog.selectExisting = false
                }
            }else if(clickedButton === StandardButton.Discard){
                fileDialog.selectExisting = true;
                openFileDialog();
            }else{
                close()
            }
        }
    }

    MessageDialog{
        id: aboutDialog
        title: qsTr("About")
        text: qsTr("A QML lyric writer\n")
        standardButtons: StandardButton.Ok
    }


    signal del()
    ConfigurationToolBar{
        id:configurationDialog
        visible: false
         buttonLeft.onClicked: {
             actions.listModel.append({"portrait":actions.str1});
             actions.listModelRight.remove(listView.currentIndex,1);

         }
         acceptButton.onClicked: {
              del()
             close()

         }

    }
}
