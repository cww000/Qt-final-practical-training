import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import Song 1.0
//import Tags 1.0

Item{
    width: appwindow.width
    height: appwindow.height
    property bool flag: false
    property alias musicPlayer:lyricPage.musicPlayer
    property alias lableContent:kid3Page.lableContent
    property alias lyricPage:lyricPage
    property alias kid3Page:kid3Page
    property alias song:song
    property alias textArea:lyricPage.textArea
    property real mX:0.0
    property real mY:0.0
    property var mapTop:{"TAG":" ","标题":" ","艺人":" ","专辑":" ","注释":" ","日期":" ","音轨编号":" ","流派":" "};
    property var mapBottom:{"ID3":" ","标题":" ","艺人":" ","专辑":" ","注释":" ","日期":" ","音轨编号":" ","流派":" "};
    //得到列数
    function getColumn(){
        var pos = lyricPage.textArea.cursorPosition;
        var start= lyricPage.textArea.cursorPosition;
        while((lyricPage.textArea.getText(start-1, start) !== "\r")&&(lyricPage.textArea.getText(start-1, start) !== "\n")&&( start !== 0)){
            start--;
        }

        return pos-start+1
    }

    function get_Tags_Meta(){
        kid3Page.lableContent.titleInputTop.text=" ";
        kid3Page.lableContent.artistInputTop.text=" ";
        kid3Page.lableContent.albumInputTop.text=" ";
        kid3Page.lableContent.dateInputTop.text=" ";
        kid3Page.lableContent.commentInputTop.text=" ";
        kid3Page.lableContent.trackNumberInputTop.text=" ";
        kid3Page.lableContent.genreInputTop.editText=" ";

        kid3Page.lableContent.titleInputBottom.text=" ";
        kid3Page.lableContent.artistInputBottom.text=" ";
        kid3Page.lableContent.albumInputBottom.text=" ";
        kid3Page.lableContent.dateInputBottom.text=" ";
        kid3Page.lableContent.commentInputBottom.text=" ";
        kid3Page.lableContent.trackNumberInputBottom.text=" ";
        kid3Page.lableContent.genreInputBottom.editText=" ";

        if(song.footerTags["TAG"]) {
            kid3Page.lableContent.musicName.text=lyricPage.musicPlayer.fileName;
            kid3Page.lableContent.titleInputTop.text=song.footerTags["标题"];
            kid3Page.lableContent.artistInputTop.text=song.footerTags["艺人"];
            kid3Page.lableContent.albumInputTop.text=song.footerTags["专辑"];
            kid3Page.lableContent.commentInputTop.text=song.footerTags["注释"];
            if(song.footerTags["日期"]===0) {
                kid3Page.lableContent.dateInputTop.text=" ";
            } else {
                kid3Page.lableContent.dateInputTop.text=song.footerTags["日期"];
            }
            if(song.footerTags["音轨编号"]===0) {
                kid3Page.lableContent.trackNumberInputTop.text= " ";
            } else {
                kid3Page.lableContent.trackNumberInputTop.text= song.footerTags["音轨编号"];
            }
           kid3Page.lableContent.genreInputTop.editText=song.footerTags["流派"];

        }
        if(song.headerTags["ID3"]) {
            kid3Page.lableContent.musicName.text=lyricPage.musicPlayer.fileName;
            kid3Page.lableContent.titleInputBottom.text=song.headerTags["标题"];
            kid3Page.lableContent.artistInputBottom.text=song.headerTags["艺人"];
            kid3Page.lableContent.albumInputBottom.text=song.headerTags["专辑"];
            kid3Page.lableContent.commentInputBottom.text=song.headerTags["注释"];
            if(song.headerTags["日期"]===0) {
                kid3Page.lableContent.dateInputBottom.text= " ";
            } else {
                kid3Page.lableContent.dateInputBottom.text= song.headerTags["日期"];
            }
            if(song.headerTags["音轨编号"]===0) {
                kid3Page.lableContent.trackNumberInputBottom.text= " ";
            } else {
                kid3Page.lableContent.trackNumberInputBottom.text= song.headerTags["音轨编号"];
            }
            kid3Page.lableContent.genreInputBottom.editText=song.headerTags["流派"];
        }
    }

    function set_Tag_Meta(){
        if(kid3Page.lableContent.titleInputTop.text===" " && kid3Page.lableContent.artistInputTop.text && kid3Page.lableContent.albumInputTop.text===" " && kid3Page.lableContent.commentInputTop.text===" " && kid3Page.lableContent.dateInputTop.text===" " && kid3Page.lableContent.trackNumberInputTop.text===" " && kid3Page.lableContent.genreInputTop.editText===" ") {
            mapTop["TAG"]=false;
        } else {
            mapTop["TAG"]=true;
        }
        mapTop["标题"]=kid3Page.lableContent.titleInputTop.text;
        mapTop["艺人"]=kid3Page.lableContent.artistInputTop.text;
        mapTop["专辑"]=kid3Page.lableContent.albumInputTop.text;
        mapTop["注释"]=kid3Page.lableContent.commentInputTop.text;
        if(kid3Page.lableContent.dateInputTop.text===" ") {
           mapTop["日期"]=0;
        } else {
            mapTop["日期"]=kid3Page.lableContent.dateInputTop.text;
        }
        if(kid3Page.lableContent.trackNumberInputTop.text===" ") {
           mapTop["音轨编号"]=0;
        } else {
            mapTop["音轨编号"]=kid3Page.lableContent.trackNumberInputTop.text;
        }
        mapTop["流派"]=kid3Page.lableContent.genreInputTop.editText;

        if(kid3Page.lableContent.titleInputBottom.text===" " && kid3Page.lableContent.artistInputBottom.text && kid3Page.lableContent.albumInputBottom.text===" " && kid3Page.lableContent.commentInputBottom.text===" " && kid3Page.lableContent.dateInputBottom.text===" " && kid3Page.lableContent.trackNumberInputBottom.text===" " && kid3Page.lableContent.genreInputBottom.editText===" ") {
            mapBottom["ID3"]=false;
        } else {
            mapBottom["ID3"]=true;
        }

        mapBottom["标题"]=kid3Page.lableContent.titleInputBottom.text;
        mapBottom["艺人"]=kid3Page.lableContent.artistInputBottom.text;
        mapBottom["专辑"]=kid3Page.lableContent.albumInputBottom.text;
        mapBottom["注释"]=kid3Page.lableContent.commentInputBottom.text;
        if(kid3Page.lableContent.dateInputBottom.text===" ") {
           mapBottom["日期"]=0;
        } else {
            mapBottom["日期"]=kid3Page.lableContent.dateInputBottom.text;
        }
        if(kid3Page.lableContent.trackNumberInputBottom.text===" ") {
           mapBottom["音轨编号"]=0;
        } else {
            mapBottom["音轨编号"]=kid3Page.lableContent.trackNumberInputBottom.text;
        }
        mapBottom["流派"]=kid3Page.lableContent.genreInputBottom.editText;

    }

    //得到行数
    function getRow(){
        var end = lyricPage.textArea.cursorPosition
        var num = 0;
        var str;
        for(var i = 0; i < end; i++){
            str = lyricPage.textArea.getText(i, i+1)
            if((str === "\r")||(str === "\n")){
                num++;
            }
        }
        return num+1
    }
    //计算时间进度
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
    ColumnLayout{
        spacing: 0
        RowLayout{
            spacing: 0
            Button{
                id:lyricPageButton
                Layout.preferredWidth:appwindow.width-kid3PageButton.width
           //     Layout.preferredWidth:appwindow.width/2
                Layout.preferredHeight: 30
                text: qsTr("Lyric")
                enabled: false
                opacity: 0.4
                onClicked: {
                    lyricPageButton.enabled=false;
                    lyricPageButton.opacity=0.4
                    kid3PageButton.opacity=1
                    kid3PageButton.enabled=true;
                }

            }
            Button{
                id:kid3PageButton
                Layout.preferredWidth: enabled ? (appwindow.width-lyricPage.textArea.width):(appwindow.width-kid3Page.catalogue.width)
          //      Layout.preferredWidth:appwindow.width/2
                Layout.preferredHeight: 30
                text: qsTr("Kid3")
                enabled: true
                opacity: 1
                onClicked: {
                    lyricPageButton.enabled=true;
                    kid3PageButton.enabled=false;
                    kid3PageButton.opacity=0.4
                    lyricPageButton.opacity=1
                }
            }
        }
        /*歌词和音乐播放界面*/
        LyricPage{
            id:lyricPage
            visible:kid3PageButton.enabled
            width: appwindow.width
            height: appwindow.height

        }

        /*kid3界面*/
        Kid3Page{
            id:kid3Page
            visible:lyricPageButton.enabled
            width: appwindow.width
            height: appwindow.height
        }
    }

    Song{
        id:song
    }


}
