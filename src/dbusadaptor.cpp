#include "dbusadaptor.h"

DBusAdaptor::DBusAdaptor(QObject *parent) : QDBusAbstractAdaptor(parent) {}

void DBusAdaptor::openUrl(const QStringList &urls) {
    if(!urls.isEmpty()) {
        emit urlReceived(urls.first());
    }
}
