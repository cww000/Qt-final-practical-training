#ifndef SONG_H
#define SONG_H

#include <QObject>
#include <QVariantMap>
class Song : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantMap headerTags READ headerTags WRITE setHeaderTags NOTIFY headerTagsChanged)
    Q_PROPERTY(QVariantMap footerTags READ footerTags WRITE setFooterTags NOTIFY footerTagsChanged)
public:
    explicit Song(QObject *parent = nullptr);
    Q_INVOKABLE void getTags(QString url);
    Q_INVOKABLE void saveTags(QString url,QVariantMap mapTop,QVariantMap mapBottom);
    void mp3Open(const char *ch);
    void flacOpen(const char *ch);
    void oggOpen(const char *ch);
    void mp3Save(const char *ch,QVariantMap mapTop,QVariantMap mapBottom);
    void flacSave(const char *ch,QVariantMap mapBottom);
    void oggSave(const char *ch,QVariantMap mapBottom);
    QVariantMap headerTags() const
    {
        return m_headerTags;
    }

    QVariantMap footerTags() const
    {
        return m_footerTags;
    }

public slots:
    void setHeaderTags(QVariantMap headerTags)
    {
        if (m_headerTags == headerTags)
            return;

        m_headerTags = headerTags;
        emit headerTagsChanged(m_headerTags);
    }

    void setFooterTags(QVariantMap footerTags)
    {
        if (m_footerTags == footerTags)
            return;

        m_footerTags = footerTags;
        emit footerTagsChanged(m_footerTags);
    }

signals:
    void headerTagsChanged(QVariantMap headerTags);

    void footerTagsChanged(QVariantMap footerTags);

private:
    QVariantMap m_headerTags;
    QVariantMap m_footerTags;
};
#endif // SONG_H
