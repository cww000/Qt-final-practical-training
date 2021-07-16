#include "fileio.h"
#include <QTextStream>
#include <QFile>
FileIo::FileIo(QObject *parent) : QObject(parent)
{

}

QString FileIo::read()
{

    QString content;
    QFile file(m_source);
    QTextStream in(&file);
    if(file.open(QIODevice::ReadOnly|QIODevice::Text)) {
        content=in.readAll();
        file.close();
    }
    return content;
}

void FileIo::write(const QString &data)
{
   QFile file(m_source);
   bool ok=file.open(QIODevice::WriteOnly|QIODevice::Text);
   if(ok) {
       QTextStream out(&file);
       out<<data;
       file.close();
   }
}
