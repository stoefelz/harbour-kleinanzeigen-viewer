TARGET = harbour-kleinanzeigen-viewer

CONFIG += sailfishapp
QT += dbus
PKGCONFIG += qt5embedwidget

SOURCES += \
    src/dbusadaptor.cpp \
    src/harbour-kleinanzeigen-viewer.cpp

HEADERS += \
    src/dbusadaptor.h

# Alle QML-Dateien und Skripte
DISTFILES += \
    com.stoefelz.kleinanzeigende.desktop \
    com.stoefelz.kleinanzeigende.service \
    qml/harbour-kleinanzeigen-viewer.qml \
    qml/pages/*.qml \
    qml/pages/*.js \
    qml/pages/*.py \
    qml/components/*.qml \
    qml/cover/*.qml \
    qml/pages/favourites/*.qml \
    qml/pages/filter/*.qml \
    qml/pages/startpage/*.qml \
    icons/*.png \
    icons/*.svg \
    rpm/harbour-kleinanzeigen-viewer.changes.in \
    rpm/harbour-kleinanzeigen-viewer.changes.run.in \
    rpm/harbour-kleinanzeigen-viewer.spec \
    rpm/harbour-kleinanzeigen-viewer.yaml \
    translations/*.ts

# Icons für Sailfish OS automatisch installieren
SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# Übersetzungen
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-kleinanzeigen-viewer-de.ts

# --- MANUELLE INSTALLS ---

# 1. Desktop Datei (muss exakt so heißen wie der D-Bus Service)
my_desktop.files = com.stoefelz.kleinanzeigende.desktop
my_desktop.path = /usr/share/applications

# 2. D-Bus Service Datei (damit der Launcher die App wecken kann)
dbusservice.files = com.stoefelz.kleinanzeigende.service
dbusservice.path = /usr/share/dbus-1/services

INSTALLS += my_desktop dbusservice
