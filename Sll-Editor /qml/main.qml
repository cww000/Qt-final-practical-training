/*最终版本*/
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import Lyric 1.0
import FileIo 1.0
import Wave 1.0
ApplicationWindow{
    width: 940
    height: 800
    visible: true
    property alias musicPlayer:content.musicPlayer
    id:appwindow
    property var listCurrent:new Array
    property var i:0

    property var timeStampIndex:0
    property bool timeFlag:false;
    //快进5秒
    function fastForward() {
        var addNum=5*1000;
        musicPlayer.audio.seek(musicPlayer.audio.position+addNum);
    }

    //快退5秒
    function goBack() {
        var addNum=5*1000;
        musicPlayer.audio.seek(musicPlayer.audio.position-addNum);
    }


    //计算时间进度,将毫秒化为时间戳
    function setTime(value) {
        var m,s,ms;
        m=(value-value%60000)/60000;
        s=((value-m*60000)-(value-m*60000)%1000)/1000;
        ms=((value-m*60000-s*1000)-(value-m*60000-s*1000)%10)/10
        if(s>=0 & s<10) {
            if(ms>=10 & ms<100) {
                actions.addTagAction.text="加入标签[0"+m+":0"+s+"."+ms+"]";
            } else {
                actions.addTagAction.text="加入标签[0"+m+":0"+s+".0"+ms+"]";
            }
        } else{
            if(ms>=10 & ms<100) {
                actions.addTagAction.text="加入标签[0"+m+":"+s+"."+ms+"]";
            } else {
                actions.addTagAction.text="加入标签[0"+m+":"+s+".0"+ms+"]";
            }
        }
    }



    MenuSeparator{id:menuSeparator}
    MenuSeparator{id:menuSeparator1}
    MenuSeparator{id:menuSeparator2}
    menuBar: MenuBar{
        id:menuBar
     //   delegate: Rectangle{color:"#E0F2F7";anchors.fill:parent}
        Menu{
            title: qsTr("&文件")

            contentData: [
                actions.newAction,
                actions.openAction,
                actions.openMusicAction,
                actions.saveAction,
                actions.saveMusicAction,
                menuSeparator,
                actions.closeAction,
                actions.exitAction
            ]
        }
        Menu{
            title: qsTr("&编辑")
            contentData: [
                actions.copyAction,
                actions.pasteAction,
                actions.cutAction,
                menuSeparator1,
                actions.undoAction,
                actions.redoAction
            ]
        }
        Menu{
            title: qsTr("&标签")
            contentData: [
                actions.addTagAction,
                actions.deleteHeaderLabelAction,
                actions.deleteAllLabelAction
            ]
        }
        Menu{
            title: qsTr("&设置")
            contentData: [
                actions.showToolBarAction,
                actions.showStatusBarAction,
                menuSeparator2,
                actions.changeFontAction,
                actions.configurationToolbarAction
            ]
        }
        Menu{
            title: qsTr("&测试播放")
            contentData: [
                actions.fastForwardAction,
                actions.goBackAction,
                actions.testAction
            ]
        }
        Menu{
            title: qsTr("&帮助")
            contentData: [
                actions.aboutAction
            ]
        }
    }
    header:ToolBar{
        id: toolBar
        RowLayout{
            ToolButton {
                id:toolBaropen
                highlighted: false
                font.bold: false
                font.underline: false
                action: actions.openAction
                Component.onCompleted: {
                    actions.openAction.flag=true
                    listCurrent[i]=actions.openAction.text;
                    i+=1;
                    for(var h=0;h<actions.listModel.count;h++) {
                        var path=actions.listModel.get(h).name;
                        if(path===actions.openAction.text) {
                            actions.listModel.remove(h,1)
                            break;
                        }
                    }
                    for(var j=0;j<i;j++) {
                        actions.listModelRight.append({"portrait":listCurrent[j]});
                    }

                }
            }
            ToolButton {
                id:toolBarAddTag
                action: actions.addTagAction

                Component.onCompleted: {
                    for(var k=0;k<actions.str.length;k++) {
                        if(actions.str[k]===actions.addTagAction.text && actions.flagAccepted) {
                            visible=false;
                            break;
                        }
                    }

                    actions.openAction.flag=true
                    for(var h=0;h<actions.listModel.count;h++) {
                        var path=actions.listModel.get(h).name;
                        if(path===actions.addTagAction.text) {
                            actions.listModel.remove(h,1)
                            break;
                        }
                    }
                    listCurrent[i]=actions.addTagAction.text;
                    i+=1;
                }
            }
            ToolButton {
                id:tooBarDeleteHeaderLabel
                action: actions.deleteHeaderLabelAction
                //  visible: !(actions.str===actions.deleteHeaderLabelAction.text && flagAccepted)
                Component.onCompleted: {


                    actions.openAction.flag=true
                    for(var h=0;h<actions.listModel.count;h++) {
                        var path=actions.listModel.get(h).name;
                        if(path===actions.deleteHeaderLabelAction.text) {
                            actions.listModel.remove(h,1)
                            break;
                        }
                    }
                    listCurrent[i]=actions.deleteHeaderLabelAction.text;
                    i+=1;
                }
            }
            ToolButton {
                id:tooBarFastForward
                action: actions.fastForwardAction

                Component.onCompleted: {

                    actions.openAction.flag=true
                    for(var h=0;h<actions.listModel.count;h++) {
                        var path=actions.listModel.get(h).name;
                        if(path===actions.fastForwardAction.text) {
                            actions.listModel.remove(h,1)
                            break;
                        }
                    }
                    listCurrent[i]=actions.fastForwardAction.text;
                    i+=1;
                }
            }
            ToolButton {
                id:toolBarGoBack
                action: actions.goBackAction

                Component.onCompleted: {

                    actions.openAction.flag=true
                    for(var h=0;h<actions.listModel.count;h++) {
                        var path=actions.listModel.get(h).name;
                        if(path===actions.goBackAction.text) {
                            actions.listModel.remove(h,1)
                            break;
                        }
                    }
                    listCurrent[i]=actions.goBackAction.text;
                    i+=1;
                }
            }
            ToolButton {
                id:tooBarTest
                action: actions.testAction

                Component.onCompleted: {

                    actions.openAction.flag=true
                    for(var h=0;h<actions.listModel.count;h++) {
                        var path=actions.listModel.get(h).name;
                        if(path===actions.testAction.text) {
                            actions.listModel.remove(h,1)
                            break;
                        }
                    }
                    listCurrent[i]=actions.testAction.text;
                    i+=1;
                }
            }
        }
    }
    footer: Rectangle{
        anchors.bottom: parent.buttom
        height: 30
        border.width: 1
        border.color: "grey"
        RowLayout{
            anchors.verticalCenter: parent.verticalCenter
            Button{
                implicitWidth: 100
                text: qsTr("行"+content.getRow()+", 列"+content.getColumn())
                background: Rectangle{
                    id: rec1
                    width: parent.width-2
                    border.width: 1
                    border.color: "white"
                }
                HoverHandler{
                    onHoveredChanged: {
                        if(hovered){
                            rec1.border.color = "lightblue"
                        }else{
                            rec1.border.color = "white"
                        }
                    }
                }
            }
            Button{
                implicitWidth: 200
                text: qsTr("播放时间"+actions.addTagAction.text.slice(4))
                background: Rectangle{
                    id: rec2
                    width: parent.width-2
                    border.width: 1
                    border.color: "white"
                }
                HoverHandler{
                    onHoveredChanged: {
                        if(hovered){
                            rec2.border.color = "lightblue"
                        }else{
                            rec2.border.color = "white"
                        }
                    }
                }
            }
            Button{
                implicitWidth: 250
                text: qsTr("当前播放歌曲:"+content.musicPlayer.fileName)
                background: Rectangle{
                    id: rec3
                    width: parent.width-2
                    border.width: 1
                    border.color: "white"
                }
                HoverHandler{
                    onHoveredChanged: {
                        if(hovered){
                            rec3.border.color = "lightblue"
                        }else{
                            rec3.border.color = "white"
                        }
                    }
                }
            }
        }
    }


    Content{
        id:content
        anchors.fill:parent

    }

    Actions{
        id:actions
        newAction.onTriggered: {
            if(content.flag === true){
                dialogs.newDialog.open()
            }else{
                content.textArea.text = "";
                dialogs.fileDialog.selectExisting = false
            }
        }
        openAction.onTriggered: {
            if(content.flag === true){
                dialogs.closeDialog.open()
            }else{
                dialogs.fileDialog.selectExisting = true;
                dialogs.openFileDialog();

            }
        }
        openMusicAction.onTriggered: {
            dialogs.openMusicDialog()

        }

        saveAction.onTriggered: {
            if(!dialogs.fileDialog.selectExisting){
                dialogs.openFileDialog()
            }else{
                var filePath=new String(dialogs.fileDialog.fileUrl);
                fileIo.source=filePath.slice(7);  //   remove file://
                fileIo.write(content.textArea.text)
                lyric_id.lyric=content.textArea.text;
            }
            content.flag = false
        }
        saveMusicAction.onTriggered: {
            content.set_Tag_Meta();
            var str= new String(dialogs.fileMusicDialog.fileUrl);
            content.song.saveTags(str.slice(7),content.mapTop,content.mapBottom);
        }

        closeAction.onTriggered:{
            if(content.flag === true){
                dialogs.newDialog.open()
            }else{
                content.textArea.text = "";
                dialogs.fileDialog.selectExisting = false
            }
        }
        exitAction.onTriggered: appwindow.close()

        cutAction.onTriggered: {
            //            content.text.toString(content.text.selectionStart,content.text.selectionEnd);
            content.textArea.cut();
        }
        copyAction.onTriggered: {
            content.textArea.copy();
        }
        pasteAction.onTriggered: {
            content.textArea.paste();
        }
        undoAction.onTriggered: content.textArea.undo()
        redoAction.onTriggered: content.textArea.redo()
        showToolBarAction.onCheckedChanged: {
            header.visible=header.visible ? false: true;  //显示或隐藏工具栏
        }
        configurationToolbarAction.onTriggered: {
            dialogs.openConfigurationDialog();
        }

        changeFontAction.onTriggered: dialogs.openFontDialog()  //打开字体对话框
        addTagAction.onTriggered:{
            content.textArea.text=lyric_id.addTag(content.textArea.text,content.textArea.cursorPosition,actions.addTagAction.text.slice(4));
        }
        deleteHeaderLabelAction.onTriggered: {
            content.textArea.text=lyric_id.deleteHeaderLabel(content.textArea.text,content.textArea.cursorPosition)
        }
        deleteAllLabelAction.onTriggered:{
            content.textArea.text=lyric_id.deleteAllLabel(content.textArea.text,content.textArea.cursorPosition)
        }


        fastForwardAction.onTriggered: {
            fastForward();     //快进5秒
        }
        goBackAction.onTriggered: {
            goBack();       //快退5秒
        }

        Timer{
            id:timerTest
            repeat: true
            running: false
            onTriggered: {
                console.log(timeStampIndex);
                if(timeFlag) {
                    lyric_id.test(lyric_id.translateStamp(lyric_id.timeStamp[timeStampIndex]));
                    timeFlag=false;
                } else {
                    lyric_id.test(lyric_id.translateStamp(lyric_id.timeStamp[timeStampIndex]));
                }
                content.textArea.cursorPosition=lyric_id.highlightPos;
                content.textArea.select(lyric_id.highlightPos,lyric_id.highlightPos+lyric_id.highlightLength);
                timeStampIndex++;
                interval=lyric_id.timeStamp[timeStampIndex]-lyric_id.timeStamp[timeStampIndex-1];
                if(content.musicPlayer.totalTimeTex===content.musicPlayer.timeTex) {
                    content.musicPlayer.pauseButton.clicked()
                }
            }
        }

        testAction.onTriggered: {
            lyric_id.lyric=content.textArea.text
            lyric_id.extract_timeStamp();
            if(!timerTest.running) {
                actions.deleteHeaderLabelAction.enabled=false;
                actions.deleteAllLabelAction.enabled=false;
                actions.addTagAction.enabled=false;
                timeStampIndex=lyric_id.findTimeInterval(actions.addTagAction.text.slice(4));
                console.log(timeStampIndex);
                timerTest.interval=lyric_id.timeDif;     //设置第一个时间间隔
                timerTest.running=true;
                timeFlag=true;
                console.log("开始测试")
            } else{
                actions.deleteHeaderLabelAction.enabled=true;
                actions.deleteAllLabelAction.enabled=true;
                actions.addTagAction.enabled=true;
                timerTest.running=false;
                console.log("结束测试")
            }
        }
        aboutAction.onTriggered: {
            dialogs.openAboutDialog()
        }
    }

    Dialogs{
        id:dialogs
        fontOpenDialog.onAccepted: {
            content.textArea.font=fontOpenDialog.font;
        }

        fileDialog.onAccepted: {
            var filePath=new String(fileDialog.fileUrl);
            fileIo.source=filePath.slice(7);  //   remove file://
            if(fileDialog.selectExisting === true){
                content.textArea.text=fileIo.read();
                content.flag = false;
                lyric_id.lyric=content.textArea.text;    //更新歌词内容
                lyric_id.extract_timeStamp();               //解析出时间戳
            }else{
                fileIo.write(content.textArea.text)
                dialogs.fileDialog.selectExisting = true
            }

        }
        fileMusicDialog.onAccepted: {
            content.musicPlayer.audio.source=dialogs.fileMusicDialog.fileUrl;
            var path=new String(fileMusicDialog.fileUrl).slice(7);
            content.musicPlayer.getMusic(path);  //得到歌曲名字
            content.song.getTags(path);         //得到歌曲的头部或者尾部信息
            content.get_Tags_Meta();             //将关联数组中的数据显示到界面


        }

        onDel:{

            for(var k=0;k<actions.str.length;k++) {
                if(actions.str[k]===actions.openAction.text) {
                    toolBaropen.visible=false;
                    break;
                }
            }
            for(var k=0;k<actions.str.length;k++) {
                if(actions.str[k]===actions.addTagAction.text) {
                    toolBarAddTag.visible=false;
                    break;
                }
            }
            for(var k=0;k<actions.str.length;k++) {
                if(actions.str[k]===actions.deleteHeaderLabelAction.text) {
                    tooBarDeleteHeaderLabel.visible=false;
                    break;
                }
            }
            for(var k=0;k<actions.str.length;k++) {
                if(actions.str[k]===actions.fastForwardAction.text) {
                    tooBarFastForward.visible=false;
                    break;
                }
            }
            for(var k=0;k<actions.str.length;k++) {
                if(actions.str[k]===actions.goBackAction.text) {
                    toolBarGoBack.visible=false;
                    break;
                }
            }
            for(var k=0;k<actions.str.length;k++) {
                if(actions.str[k]===actions.testAction.text) {
                    tooBarTest.visible=false;
                    break;
                }
            }

        }

    }
    /*C++类*/
    FileIo{
        id:fileIo
    }

    Lyric{
        id:lyric_id
    }

    Item {
        id: name
        Wave{
            id:wave
        }
    }
}

/*##^##
Designer {
    D{i:0}D{i:31;invisible:true}
}
##^##*/
