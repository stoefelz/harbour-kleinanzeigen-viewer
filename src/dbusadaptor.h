#ifndef DBUSADAPTOR_H
#define DBUSADAPTOR_H

#include <QObject>
#include <QDBusAbstractAdaptor>

class DBusAdaptor : public QDBusAbstractAdaptor {
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "com.stoefelz.kleinanzeigende")

public:
    explicit DBusAdaptor(QObject *parent = nullptr);
public slots:
    Q_NOREPLY void openUrl(const QStringList &urls);
signals:
    void urlReceived(const QString &url);
};

#endif // DBUSADAPTOR_H
