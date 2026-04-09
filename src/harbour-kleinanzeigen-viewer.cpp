#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif
#include <sailfishapp.h>
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QDBusConnection>
#include <QDBusConnectionInterface>
#include <QDBusInterface>
#include "dbusadaptor.h"

int main(int argc, char *argv[])
{
    // SailfishApp::main() will display "qml/harbour-kleinanzeigen-viewer.qml", if you need more
    // control over initialization, you can use:
    //
    //   - SailfishApp::application(int, char *[]) to get the QGuiApplication *
    //   - SailfishApp::createView() to get a new QQuickView * instance
    //   - SailfishApp::pathTo(QString) to get a QUrl to a resource file
    //   - SailfishApp::pathToMainQml() to get a QUrl to the main QML file
    //
    // To display the view, call "show()" (will show fullscreen on device).

   // return SailfishApp::main(argc, argv);
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    // get url from argument
    QString startupUrl;
    if(argc > 1) {
        startupUrl = QString::fromUtf8(argv[1]);
    }

    //register dbus service
    QString serviceName = "com.stoefelz.kleinanzeigende";
    QDBusConnection bus = QDBusConnection::sessionBus();

    //if already instance is running -> service is available
    if (bus.interface()->isServiceRegistered(serviceName)) {
        if (argc > 1) {
            QDBusInterface iface(serviceName, "/", serviceName, bus);
            iface.call(QDBus::NoBlock, "openUrl", QString::fromUtf8(argv[1]));
        }
        //close next instance of app
        return 0;
    }

    bus.registerService(serviceName);

    //register adaptor
    DBusAdaptor *adaptor = new DBusAdaptor(view.data());
    bus.registerObject("/", view.data());

    view->rootContext()->setContextProperty("startupUrl", startupUrl);

    //signal
    QObject::connect(adaptor, &DBusAdaptor::urlReceived, view.data(), [view = view.data()](const QString &url) {
        QMetaObject::invokeMethod(view->rootObject(), "handleNewUrl", Q_ARG(QVariant, url));
        view->raise();
        view->requestActivate();
    });

    view->setSource(SailfishApp::pathToMainQml());
    view->show();
    return app->exec();
}
