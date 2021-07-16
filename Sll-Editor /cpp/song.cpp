#include "song.h"
#include <QDebug>
#include <id3/tag.h>
#include <QVariant>
#include <taglib/id3v1tag.h>
#include <taglib/id3v2tag.h>
#include <taglib/tag.h>
#include <taglib/mpegfile.h>
#include <taglib/flacfile.h>
Song::Song(QObject *parent) : QObject(parent)
{
    m_headerTags["ID3"]=false;
    m_headerTags["标题"]=" ";
    m_headerTags["艺人"]=" ";
    m_headerTags["专辑"]=" ";
    m_headerTags["注释"]=" ";
    m_headerTags["日期"]=" ";
    m_headerTags["音轨编号"]=" ";
    m_headerTags["流派"]=" ";

    m_footerTags["TAG"]=false;
    m_footerTags["标题"]=" ";
    m_footerTags["艺人"]=" ";
    m_footerTags["专辑"]=" ";
    m_footerTags["注释"]=" ";
    m_footerTags["日期"]=" ";
    m_footerTags["音轨编号"]=" ";
    m_footerTags["流派"]=" ";
}

void Song::getTags(QString url)
{
    QByteArray ba=url.toUtf8();
    const char *ch=ba.data();

    QString end;  //歌名后缀
    for(int i=url.length()-1;i>=0;i--) {
        if(url[i]==".") {
            end=url.mid(i+1,url.length()-i);
            break;
        }
    }
    if(end=="mp3") {
        mp3Open(ch);
    } else if(end=="flac"){
        flacOpen(ch);
    } else if(end=="ogg"){
        oggOpen(ch);
    }
}

void Song::saveTags(QString url,QVariantMap mapTop,QVariantMap mapBottom)
{
    QByteArray ba=url.toUtf8();
    const char *ch=ba.data();

    QString end;
    for(int i=url.length()-1;i>=0;i--) {
        if(url[i]==".") {
            end=url.mid(i+1,url.length()-i);
            break;
        }
    }
    if(end=="mp3") {
        mp3Save(ch,mapTop,mapBottom);
    } else if(end=="flac" || end=="ogg"){
        flacSave(ch,mapBottom);
    } else if(end=="ogg"){
        oggSave(ch,mapBottom);
    }
}

void Song::mp3Open(const char *ch)
{
    TagLib::MPEG::File f(ch);
    TagLib::ID3v1::Tag *tag1=f.ID3v1Tag();
    TagLib::ID3v2::Tag *tag2=f.ID3v2Tag();
    m_footerTags.clear();
    m_headerTags.clear();

    if(!tag1->isEmpty()) {
        m_footerTags["TAG"]=true;
        m_footerTags["标题"]=tag1->title().toCString();
        m_footerTags["艺人"]=tag1->artist().toCString();
        m_footerTags["专辑"]=tag1->album().toCString();
        m_footerTags["注释"]=tag1->comment().toCString();
        m_footerTags["日期"]=tag1->year();
        m_footerTags["音轨编号"]=tag1->track();
        m_footerTags["流派"]=tag1->genre().toCString();

//        qDebug()<<m_footerTags["标题"].toString()<<"\t"<<m_footerTags["艺人"].toString()
//                                              <<"\t"<<m_footerTags["日期"].toInt()<<"\t"
//                                              <<m_footerTags["音轨编号"].toInt()<<"\t"
//                                              <<m_footerTags["流派"].toString();
    }
    if(!tag2->isEmpty()) {
        m_headerTags["ID3"]=true;
        m_headerTags["标题"]=tag2->title().toCString();
        m_headerTags["艺人"]=tag2->artist().toCString();
        m_headerTags["专辑"]=tag2->album().toCString();
        m_headerTags["注释"]=tag2->comment().toCString();
        m_headerTags["日期"]=tag2->year();
        m_headerTags["音轨编号"]=tag2->track();
        m_headerTags["流派"]=tag2->genre().toCString();

//        qDebug()<<m_headerTags["标题"].toString()<<"\t"<<m_headerTags["艺人"].toString()
//                                              <<"\t"<<m_headerTags["日期"].toInt()<<"\t"
//                                              <<m_headerTags["音轨编号"].toInt()<<"\t"
//                                              <<m_headerTags["流派"].toString();
    }
}

void Song::flacOpen(const char *ch)
{
    TagLib::FLAC::File f(ch);
    TagLib::Tag *tag2=f.tag();
    m_headerTags.clear();
    m_footerTags.clear();
    if(!tag2->isEmpty()) {
        m_headerTags["ID3"]=true;
        m_headerTags["标题"]=tag2->title().toCString();
        m_headerTags["艺人"]=tag2->artist().toCString();
        m_headerTags["专辑"]=tag2->album().toCString();
        m_headerTags["注释"]=tag2->comment().toCString();
        m_headerTags["日期"]=tag2->year();
        m_headerTags["音轨编号"]=tag2->track();
        m_headerTags["流派"]=tag2->genre().toCString();

//        qDebug()<<m_headerTags["标题"].toString()<<"\t"<<m_headerTags["艺人"].toString()
//                                              <<"\t"<<m_headerTags["日期"].toInt()<<"\t"
//                                              <<m_headerTags["音轨编号"].toInt()<<"\t"
//                                              <<m_headerTags["流派"].toString();
    }
}

void Song::oggOpen(const char *ch)
{
    m_footerTags.clear();
    m_headerTags.clear();


    qDebug()<<"this is ogg music";
}

void Song::mp3Save(const char *ch, QVariantMap mapTop, QVariantMap mapBottom)
{
    TagLib::String str;
    TagLib::MPEG::File f(ch);
    TagLib::ID3v1::Tag *tag1=f.ID3v1Tag();
    TagLib::ID3v2::Tag *tag2=f.ID3v2Tag();
    QByteArray ba;

    if(mapTop["TAG"].toBool()) {
        ba=mapTop["标题"].toString().toUtf8();
        str=ba.data();
        tag1->setTitle(str);

        ba=mapTop["艺人"].toString().toUtf8();
        str=ba.data();
        tag1->setArtist(str);

        ba=mapTop["专辑"].toString().toUtf8();
        str=ba.data();
        tag1->setAlbum(str);

        ba=mapTop["注释"].toString().toUtf8();
        str=ba.data();
        tag1->setComment(str);

        tag1->setYear(mapTop["日期"].toUInt());

        tag1->setTrack(mapTop["音轨编号"].toUInt());

        ba=mapTop["流派"].toString().toUtf8();
        str=ba.data();
        tag1->setGenre(str);
    }

    if(mapBottom["ID3"].toBool()) {
        ba=mapBottom["标题"].toString().toUtf8();
        str=ba.data();
        tag2->setTitle(str);

        ba=mapBottom["艺人"].toString().toUtf8();
        str=ba.data();
        tag2->setArtist(str);

        ba=mapBottom["专辑"].toString().toUtf8();
        str=ba.data();
        tag2->setAlbum(str);

        ba=mapBottom["注释"].toString().toUtf8();
        str=ba.data();
        tag2->setComment(str);

        tag2->setYear(mapBottom["日期"].toUInt());

        tag2->setTrack(mapBottom["音轨编号"].toUInt());

        ba=mapBottom["流派"].toString().toUtf8();
        str=ba.data();
        tag2->setGenre(str);
    }
    qDebug()<<mapBottom["标题"].toString();
    if(f.save()) {
        qDebug()<<"save successfully";
    } else {
        qDebug()<<"save field";
    }

}

void Song::flacSave(const char *ch,QVariantMap mapBottom)
{
    TagLib::FLAC::File f(ch);
    TagLib::Tag *tag2=f.tag();
    QByteArray ba;
    TagLib::String str;

    if(mapBottom["ID3"].toBool()) {
        ba=mapBottom["标题"].toString().toUtf8();
        str=ba.data();
        tag2->setTitle(str);

        ba=mapBottom["艺人"].toString().toUtf8();
        str=ba.data();
        tag2->setArtist(str);

        ba=mapBottom["专辑"].toString().toUtf8();
        str=ba.data();
        tag2->setAlbum(str);

        ba=mapBottom["注释"].toString().toUtf8();
        str=ba.data();
        tag2->setComment(str);

        tag2->setYear(mapBottom["日期"].toUInt());

        tag2->setTrack(mapBottom["音轨编号"].toUInt());

        ba=mapBottom["流派"].toString().toUtf8();
        str=ba.data();
        tag2->setGenre(str);
    }
    qDebug()<<mapBottom["标题"].toString();
    if(f.save()) {
        qDebug()<<"save successfully";
    } else {
        qDebug()<<"save field";
    }

}

void Song::oggSave(const char *ch,QVariantMap mapBottom)
{
    TagLib::FLAC::File f(ch);
    TagLib::ID3v2::Tag *tag2=f.ID3v2Tag();
    QByteArray ba;
    TagLib::String str;

    if(mapBottom["ID3"].toBool()) {
        ba=mapBottom["标题"].toString().toUtf8();
        str=ba.data();
        tag2->setTitle(str);

        ba=mapBottom["艺人"].toString().toUtf8();
        str=ba.data();
        tag2->setArtist(str);

        ba=mapBottom["专辑"].toString().toUtf8();
        str=ba.data();
        tag2->setAlbum(str);

        ba=mapBottom["注释"].toString().toUtf8();
        str=ba.data();
        tag2->setComment(str);

        tag2->setYear(mapBottom["日期"].toUInt());

        tag2->setTrack(mapBottom["音轨编号"].toUInt());

        ba=mapBottom["流派"].toString().toUtf8();
        str=ba.data();
        tag2->setGenre(str);
    }

    if(f.save()) {
        qDebug()<<"save successfully";
    } else {
        qDebug()<<"save field";
    }
}
