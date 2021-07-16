#ifndef FILECONTENT_H
#define FILECONTENT_H

#include <QObject>
class FileIo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
public:
    explicit FileIo(QObject *parent = nullptr);
    Q_INVOKABLE QString read();
    Q_INVOKABLE void write(const QString &data);

    void setSource(const QString &source){m_source=source;}
    QString source() {return m_source;}
signals:
    void sourceChanged(const QString &source);
private:
    QString m_source;
};

#endif // FILECONTENT_H
