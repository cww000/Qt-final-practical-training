#include "waveform.h"
#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QWidget>
#include <QVector>
#include <QTimer>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QWindow>
WaveForm::WaveForm(QOpenGLWidget *widget):QOpenGLWidget(widget)
{
}

void WaveForm::start()
{
    resize(600,300);
    short pcm_In=0;
    int size=0;
    FILE *fp=fopen("../out.pcm","rb+");
    while(!feof(fp)) {
        size=fread(&pcm_In,2,1,fp);       //读取音频数据，1个数据两个字节
        if(size>0) {
            vertices.push_back((float)pcm_In/30000);
        }
    }
    fclose(fp);
    istart=vertices.begin();
    iend=vertices.begin()+4410;
}

void WaveForm::initializeGL()
{
    initializeOpenGLFunctions();  //这个是qt使用opengl方法接口
    start();
    timer();

}

void WaveForm::paintGL()
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);   //设置背景
    glClear(GL_COLOR_BUFFER_BIT);
    glLineWidth(10);
    glBegin(GL_LINES);
    float xstart=-1.0;
    glColor3f(0,0.0f,0.1f);
    for(QVector<float>::iterator it=istart;it!=iend;it++) {
        if(*it<0) {
            *it=(*it)*(-1);
        }
        xstart=xstart+0.03;
        glVertex2f(xstart,0);   //绘制直线，上下两个点
        glVertex2f(xstart,*it);
    }

    glEnd();
}



void WaveForm::timer()
{
    istart+=4410;
    iend+=4410;
    if(istart<vertices.end()-1) {  //设置定时器，要start没有到达最后一个数据
        update();
        QTimer::singleShot(100,this,SLOT(timer()));
    } else {
        qDebug()<<"结束";
    }

}

Wave::Wave()
{

}

void Wave::show()
{
    wav=new WaveForm;
    wav->show();
}

void Wave::close()
{
    wav->close();
}
