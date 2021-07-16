import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import QtMultimedia 5.8

Rectangle{
    Layout.fillWidth: true
    Layout.fillHeight: true
    property string fileName:" "         //歌名
    property string  filePath:" "          //歌曲所在的目录
    property string  filePostfix:" "            //歌曲的后缀
    property alias timeTex:timeTex
    property alias totalTimeTex:totalTimeTex
    property alias startButton: startButton
    property alias pauseButton: pauseButton
    property alias audio:audio
    signal start()
    signal pause()
    signal stop()

    id:musicDialog
    function openMusicWindow() {
       window.visible=true;
   }
    //得到歌曲名字以及所在的目录路径
    function getMusic(path){
        for(var i=path.length-1;i>=0;i--) {
            if(path[i]==="/") {
                fileName=path.slice(i+1);
                var len=path.length-fileName.length;
                filePath=path.slice(0,len);
                break;
            }
        }
        for(var j=path.length-1;j>=0;j--) {
            if(path[j]===".") {
                filePostfix=path.slice(j+1);
                break;
            }
        }

        //如果后缀是ogg或者flac就隐藏尾部标签框
        content.lableContent.contentOne.visible=true;
        if(filePostfix==="flac" | filePostfix==="ogg") {
            content.lableContent.contentOne.visible=false;
        }
    }

    //得到歌曲总时长
    function setTime(playTime) {
        var m,s;
        playTime=(playTime-playTime%1000)/1000;
        m=(playTime-playTime%60)/60
        s=playTime-m*60
        totalTimeTex.text=m+":"+s;
    }
    //得到进度条当前播放时间
    function setTime1(playTime) {
        var m,s;
        playTime=(playTime-playTime%1000)/1000;
        m=(playTime-playTime%60)/60
        s=playTime-m*60
        if(s>=0&s<10) {
            timeTex.text=m+":0"+s;
        } else {
            timeTex.text=m+":"+s;
        }
    }
    ColumnLayout{
        id:columLay1
        anchors.fill: parent
        Layout.alignment: Qt.AlignTop
        Text {
            id: songName
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 20
            text:"当前播放:"+fileName
        }
        RowLayout{
            id:rowLay1
            Layout.alignment: Qt.AlignHCenter
            spacing: 10
            RoundButton{
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                icon.name: "media-playback-stop"
                onClicked: {
                    startButton.visible=true;
                    pauseButton.visible=false;
                    audio.stop()
                    stop();  //向歌词编辑界面发送停止信号
                }
            }
            RoundButton{
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                id:startButton
                icon.name: "media-playback-start"
                visible: true
                onClicked: {
                    if(fileName!=" ") {
                        startButton.visible=false;
                        pauseButton.visible=true;
                        audio.play();
                        start();  //向歌词编辑界面发送开始信号
                    }
                }
            }
            RoundButton{
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                id:pauseButton
                icon.name: "media-playback-pause"
                visible: false
                onClicked: {
                    startButton.visible=true;
                    pauseButton.visible=false;
                    audio.pause()
                    pause();   //向歌词编辑界面发送暂停信号
                    timerTest.stop()
                    content.textArea.undo()

                }
            }
            Text {
                id: timeTex
                text:qsTr("0:00")
            }
            Slider{
                id:audioSlider
                to:audio.duration
                value: audio.position
                Layout.preferredWidth: 500
                onValueChanged: {
                    setTime1(value);
                    audio.seek(value);
                }
            }
            Text {
                id: totalTimeTex
                text:qsTr("0:00")
            }
            RoundButton{
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                id:volumButton
                Layout.leftMargin: 30
                icon.name: "audio-volume-medium"
                onClicked: {
                   if(volumSlider.visible) {
                     volumSlider.visible=false;
                   } else{
                      volumSlider.visible=true;
                   }
               }
            }
            Slider{
                id:volumSlider
                visible: false
                to:1.0
                value: audio.volume
                Layout.preferredWidth: 100
                onValueChanged: {
                    audio.volume=value  //音量大小0-1.0
                }
            }
        }
    }
    Audio{
        id:audio
        onDurationChanged: {
            var playTime=audio.duration;
            setTime(playTime);
        }
    }
}
