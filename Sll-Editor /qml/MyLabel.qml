import QtQuick.Layouts 1.0
import QtQuick.Controls 2.15
import QtQuick 2.15
Item {
    id:item1
    anchors.fill: parent
    anchors.right: parent.right
    anchors.top:parent.top
    property alias titleInputTop:contentOne.titleInput
    property alias artistInputTop:contentOne.artistInput
    property alias albumInputTop:contentOne.albumInput
    property alias commentInputTop:contentOne.commentInput
    property alias dateInputTop:contentOne.dateInput
    property alias trackNumberInputTop:contentOne.trackNumberInput
    property alias genreInputTop:contentOne.genreInput

    property alias titleInputBottom:contentTwo.titleInput
    property alias artistInputBottom:contentTwo.artistInput
    property alias albumInputBottom:contentTwo.albumInput
    property alias commentInputBottom:contentTwo.commentInput
    property alias dateInputBottom:contentTwo.dateInput
    property alias trackNumberInputBottom:contentTwo.trackNumberInput
    property alias genreInputBottom:contentTwo.genreInput

    property alias musicName:musicName
    property alias contentOne:contentOne

    ColumnLayout{
        id:columnLayout
        Layout.alignment: Qt.AlignTop
        spacing: 20
        ColumnLayout{
            width: parent.width

            RowLayout{
                id: fileRow
                Layout.fillWidth: true
                Button{
                    id: file
                    text: "+"
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    Layout.topMargin: 5
                    onClicked: {
                        if(file.text === "-"){
                            file.text = "+"
                            name.visible = true
                            format.visible = true
                        }else{
                            file.text = "-"
                            name.visible = false
                            format.visible = false
                        }
                    }
                }

                Label{text: qsTr("文件(I)")}
                Label{text: qsTr("")}
            }
            RowLayout{
                id: name
                Layout.fillWidth: true
                Label{text: qsTr("名称:")}
                TextField{
                    id:musicName
                    Layout.fillWidth: true
                    Layout.minimumWidth: 200
                }
            }
            RowLayout{
                id: format
                Layout.fillWidth: true
                Label{text: qsTr("格式:")}
                ComboBox {
                    id: formatCom
                    textRole: "text"
                    Layout.fillWidth: true
                    editable: true
                    model: ListModel {
                        id: model
                        ListElement { text: "%{artist}-%{album}/%{track}%{title}" }
                        ListElement { text: "%{artist}-%{album}/%{track}.%{title}" }
                        ListElement { text: "%{artist}-[%{year}]%{album}/%{track}%{title}" }
                        ListElement { text: "%{artist}-[%{year}]%{album}/%{track}.%{title}" }
                        ListElement { text: "%{artist}-%{album}(%{year})/%{track}-%{title}" }
                        ListElement { text: "%{artist}/%{album}/%{track}%{title}" }
                        ListElement { text: "%{artist}/%{album}/%{track}.%{title}" }
                        ListElement { text: "%{artist}/[%{year}]%{album}/%{track}%{title}" }
                        ListElement { text: "%{artist}/[%{year}]%{album}/%{track}.%{title}" }
                    }
                    MouseArea{
                        id: hoverEvent
                        anchors.fill: formatCom
                        hoverEnabled: false
                        onEntered: {
                            information_rec.x = mouseX-220
                            information_rec.visible = true
                        }
                        onExited: information_rec.visible = false
                        onClicked:{
                            information_rec.visible = false
                            hoverEnabled = false
                            enabled = false
                        }
                    }
                    HoverHandler{
                        target: formatCom
                        onHoveredChanged: {
                            if(hovered){
                                hoverEvent.enabled = true
                                hoverEvent.hoverEnabled = true
                            }
                        }
                    }
                }


                Button{text: qsTr("标签1");Layout.preferredWidth: 50}
                Button{text: qsTr("标签2");Layout.preferredWidth: 50}
            }
        }
        Rectangle{
            id: information_rec
            visible: false
            y: 130
            z:2
            border.width: 1
            border.color: "red"
            ListView{
                width: 260
                height: 540
                model:informationModel
                delegate:RowLayout{
                    spacing: 0
                    Rectangle{
                        color: "black"
                        width: 60
                        height: 20
                        Text{color: "white";text:formate_arc}
                    }
                    Rectangle{
                        color: "black"
                        width: 100
                        height: 20
                        Text{color: "white";text:title_arc}
                    }
                    Rectangle{
                        color:"black"
                        width: 100
                        height: 20
                        Text{color: "white";text:title}
                    }
                }
            }
            ListModel{
                id:informationModel
                ListElement{formate_arc:"%s";title_arc:"%{title}";title:"标题"}
                ListElement{formate_arc:"%l";title_arc:"%{album}";title:"专辑"}
                ListElement{formate_arc:"%a";title_arc:"%{artist}";title:"艺人"}
                ListElement{formate_arc:"%c";title_arc:"%{comment}";title:"注释"}
                ListElement{formate_arc:"%y";title_arc:"%{year}";title:"年份"}
                ListElement{formate_arc:"%g";title_arc:"%{genre}";title:"流派"}
                ListElement{formate_arc:"%f";title_arc:"%{file}";title:"文件名"}
                ListElement{formate_arc:"%p";title_arc:"%{filepath}";title:"文件的绝对路径"}
                ListElement{formate_arc:"%u";title_arc:"%{dirname}";title:"目录名"}
                ListElement{formate_arc:"%O";title_arc:"%{tag1}";title:"标签1"}
                ListElement{formate_arc:"%o";title_arc:"%{tag2}";title:"标签2"}
                ListElement{formate_arc:"%n";title_arc:"%{tracks}";title:"音轨编号"}
                ListElement{formate_arc:"%ha...";title_arc:"%h{artist}";title:"HTML转义符"}

            }
        }
        ColumnLayout{
            id:columnLayout1
            Layout.alignment: Qt.AlignTop
            spacing: 10
            RowLayout{
                Button{
                    id:labelButtonOne
                    text: labelOne.visible ? qsTr("+"):qsTr("-")
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    onClicked: {
                        if(labelOne.visible) {
                            labelOne.visible=false;
                            columnLayoutButtonsOne.visible=false;
                        }else{
                            labelOne.visible=true;
                            columnLayoutButtonsOne.visible=true
                        }
                    }
                }
                Text {
                    id: labelOneText
                    text: qsTr("标签1:ID3v1.1")
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Rectangle{
                    id:labelOne
                    height: 250
                    Layout.preferredWidth: item1.width-fromLabelOne.width
                    border.color: "lightblue"
                    LabelContent{
                        id:contentOne
                        anchors.fill: labelOne
                  //      anchors.bottomMargin: 0
                    }
                }
                ColumnLayout{
                    id:columnLayoutButtonsOne
                    Layout.alignment: Qt.AlignTop
                    Button{
                        id:fromLabelTwo
                        text: qsTr("从标签2")
                    }
                    Button{
                        id:labelOneCopyButton
                        text: qsTr("复制")
                    }
                    Button{
                        id:labelOnePasteButton
                        text: qsTr("粘贴")
                    }
                    Button{
                        id:labelOneRemoveButton
                        text: qsTr("移除")
                    }
                }
            }
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignTop
            spacing: 10
            RowLayout{
                Button{
                    id:labelButtonTwo
                    text: labelTwo.visible ? qsTr("+"):qsTr("-")
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    onClicked: {
                        if(labelTwo.visible) {
                            labelTwo.visible=false;
                            columnLayoutButtonsTwo.visible=false;
                        }else{
                            labelTwo.visible=true;
                            columnLayoutButtonsTwo.visible=true
                        }
                    }
                }
                Text {
                    id: labelTwoText
                    text: qsTr("标签2:ID3v2.0")
                }
            }
            RowLayout{
                id:rowLayoutLabelTwo
                Layout.fillWidth: true
                Rectangle{
                    id:labelTwo
                    Layout.preferredWidth: item1.width-fromLabelOne.width
                    height: 250
                    border.color: "lightblue"
                    LabelContent{
                        id:contentTwo
                        anchors.fill: labelTwo
                    }
                }
                ColumnLayout{
                    Layout.alignment: Qt.AlignTop
                    id:columnLayoutButtonsTwo
                    Button{
                        id:fromLabelOne
                        text: qsTr("从标签1")

                    }
                    Button{
                        id:labelTwoCopyButton
                        text: qsTr("复制")
                    }
                    Button{
                        id:labelTwoPasteButton
                        text: qsTr("粘贴")
                    }
                    Button{
                        id:labelTwoRemoveButton
                        text: qsTr("移除")
                    }
                    Button{
                        id:labelTwoDeleteButton
                        text: qsTr("删除")
                    }
                }
            }
        }
    }
}
