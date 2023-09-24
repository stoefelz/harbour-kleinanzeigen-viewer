# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = ek_viewer

CONFIG += sailfishapp

PKGCONFIG += qt5embedwidget

SOURCES += src/ek_viewer.cpp

DISTFILES += qml/ek_viewer.qml \
    qml/cover/CoverPage.qml \
    qml/pages/About.qml \
    qml/pages/Error.qml \
    qml/pages/Filter.qml \
    qml/pages/FilterProperties.qml \
    qml/pages/ItemView.qml \
    qml/pages/LoadItem.qml \
    qml/pages/PictureCarussel.qml \
    qml/pages/PossibleFilterValues.qml \
    qml/pages/StartPageWithSearchResults.qml \
    qml/pages/WebView.qml \
    qml/pages/ZipSelection.qml \
    qml/pages/get_search_entries.py \
    rpm/ek_viewer.changes.in \
    rpm/ek_viewer.changes.run.in \
    rpm/ek_viewer.spec \
    rpm/ek_viewer.yaml \
    translations/*.ts \
    ek_viewer.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/ek_viewer-de.ts
