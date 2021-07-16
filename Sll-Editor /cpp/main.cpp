#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "fileio.h"
#include "lyric.h"
#include <QApplication>
#include "song.h"
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperty>
#include <QWindow>
#include "waveform.h"
#include "decode.h"
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

  //  QGuiApplication app(argc, argv);
    QApplication app(argc,argv);
    QQmlApplicationEngine engine;
    Decode d;
    engine.rootContext()->setContextObject(&d);
    QCoreApplication::setOrganizationName("s");
    qmlRegisterType<FileIo, 1>("FileIo", 1, 0, "FileIo");
    qmlRegisterType<Song, 1>("Song", 1, 0, "Song");
    qmlRegisterType<Lyric, 1>("Lyric", 1, 0, "Lyric");
    qmlRegisterType<Wave, 1>("Wave", 1, 0, "Wave");
    const QUrl url(QStringLiteral("../qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

//    QObject *QmlObj=engine.rootObjects().first();//获取QMl的源对象
//    QWindow *QmlWindow=qobject_cast<QWindow *>(QmlObj);//获取qml在的源窗口
//   // QmlWindow->setTitle("闻天语");//设置一个窗口标签，确认自己拿到的窗口句柄就是自己想要的
// //   WId parent_HWND = QmlWindow->winId();  //Qml窗口的句柄
//    Wave w;
//    WaveForm *waveForm=new WaveForm;
//  //  waveForm->setProperty("hjdbvdkb",)
//    w.wav->setAttribute(Qt::WA_NativeWindow);
//    w.wav->winId();//必须调用，才能为widget创建句柄，否则将会失败
//    w.wav->windowHandle()->setParent(QmlWindow);
// //   QObject *object=*engine.rootObjects().begin();
//    w.wav->move(80,700);

    return app.exec();
}
