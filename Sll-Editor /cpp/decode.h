#ifndef DECODE_H
#define DECODE_H

#include <QObject>

class Decode : public QObject
{
    Q_OBJECT
public:
    explicit Decode(QObject *parent = nullptr);
    Q_INVOKABLE bool decode(QString filePath);
signals:


};

#endif // DECODE_H
