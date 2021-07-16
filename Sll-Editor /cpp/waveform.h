#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QWidget>
#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QVector>
#include <QObject>
class WaveForm :public QOpenGLWidget,protected QOpenGLFunctions
{
    Q_OBJECT
public:
    explicit WaveForm(QOpenGLWidget *widget = nullptr);
protected:
    void initializeGL();
   // void resizeGL(int w,int h);
    void paintGL();
    void play();
    void start();
public slots:
    void timer();
private:
    QVector<float>::iterator istart;
    QVector<float>::iterator iend;
    QVector<float> vertices;

};

class Wave:public WaveForm
{
    Q_OBJECT
public:
    explicit Wave();
    Q_INVOKABLE void show();
    Q_INVOKABLE void close();
private:
    WaveForm *wav;
};


#endif // MAINWINDOW_H
