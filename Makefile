#############################################################################
# Makefile for building: ek_viewer
# Generated by qmake (3.0) (Qt 5.6.3)
# Project:  ek_viewer.pro
# Template: app
# Command: /usr/lib/qt5/bin/qmake 'QMAKE_CFLAGS_RELEASE=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CFLAGS_DEBUG=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CXXFLAGS_RELEASE=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CXXFLAGS_DEBUG=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' QMAKE_STRIP=: PREFIX=/usr LIBDIR=/usr/lib -o Makefile ek_viewer.pro
#############################################################################

MAKEFILE      = Makefile

####### Compiler, tools and options

CC            = gcc
CXX           = g++
DEFINES       = -DQT_NO_DEBUG -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB
CFLAGS        = -pipe -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi -fPIC -fvisibility=hidden -fvisibility-inlines-hidden -Wall -W -D_REENTRANT -fPIC $(DEFINES)
CXXFLAGS      = -pipe -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi -fPIC -fvisibility=hidden -fvisibility-inlines-hidden -Wall -W -D_REENTRANT -fPIC $(DEFINES)
INCPATH       = -I. -isystem /usr/include/sailfishapp -I/usr/lib -isystem /usr/include/xulrunner-qt5-78.15.1 -isystem /usr/include/nspr4 -isystem /usr/include/mdeclarativecache5 -isystem /usr/include/qt5 -isystem /usr/include/qt5/QtQuick -isystem /usr/include/qt5/QtGui -isystem /usr/include/qt5/QtQml -isystem /usr/include/qt5/QtNetwork -isystem /usr/include/qt5/QtCore -I. -I/usr/share/qt5/mkspecs/linux-g++
QMAKE         = /usr/lib/qt5/bin/qmake
DEL_FILE      = rm -f
CHK_DIR_EXISTS= test -d
MKDIR         = mkdir -p
COPY          = cp -f
COPY_FILE     = cp -f
COPY_DIR      = cp -f -R
INSTALL_FILE  = install -m 644 -p
INSTALL_PROGRAM = install -m 755 -p
INSTALL_DIR   = cp -f -R
DEL_FILE      = rm -f
SYMLINK       = ln -f -s
DEL_DIR       = rmdir
MOVE          = mv -f
TAR           = tar -cf
COMPRESS      = gzip -9f
DISTNAME      = ek_viewer1.0.0
DISTDIR = /home/sfos_app/ek_viewer/.tmp/ek_viewer1.0.0
LINK          = g++
LFLAGS        = -Wl,-O1 -Wl,-rpath,/usr/share/ek_viewer/lib
LIBS          = $(SUBLIBS) -L/usr/lib/xulrunner-qt5-devel-78.15.1/lib -lqt5embedwidget -lxpcomglue -lxul -Wl,-rpath,/usr/lib/xulrunner-qt5-78.15.1 -lplds4 -lplc4 -lnspr4 -ldl -lsailfishapp -pie -rdynamic -lmdeclarativecache5 -lQt5Quick -lQt5Gui -lQt5Qml -lQt5Network -lQt5Core -lGLESv2 -lpthread 
AR            = ar cqs
RANLIB        = 
SED           = sed
STRIP         = :

####### Output directory

OBJECTS_DIR   = ./

####### Files

SOURCES       = src/ek_viewer.cpp 
OBJECTS       = ek_viewer.o
DIST          = qml/ek_viewer.qml \
		qml/cover/CoverPage.qml \
		qml/pages/About_Page.qml \
		qml/pages/Error_Page.qml \
		qml/pages/FirstPage.qml \
		qml/pages/PictureCarussel.qml \
		qml/pages/SecondPage.qml \
		qml/pages/SilicaListView_for_Item.qml \
		qml/pages/WebView.qml \
		qml/pages/filter_page.qml \
		qml/pages/get_item_entry.py \
		qml/pages/get_search_entries.py \
		rpm/ek_viewer.changes.in \
		rpm/ek_viewer.changes.run.in \
		rpm/ek_viewer.spec \
		rpm/ek_viewer.yaml \
		translations/*.ts \
		ek_viewer.desktop \
		/usr/share/qt5/mkspecs/features/spec_pre.prf \
		/usr/share/qt5/mkspecs/common/unix.conf \
		/usr/share/qt5/mkspecs/common/linux.conf \
		/usr/share/qt5/mkspecs/common/sanitize.conf \
		/usr/share/qt5/mkspecs/common/gcc-base.conf \
		/usr/share/qt5/mkspecs/common/gcc-base-unix.conf \
		/usr/share/qt5/mkspecs/common/g++-base.conf \
		/usr/share/qt5/mkspecs/common/g++-unix.conf \
		/usr/share/qt5/mkspecs/qconfig.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_bluetooth.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_bluetooth_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_compositor.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_compositor_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_concurrent.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_concurrent_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_contacts.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_contacts_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_core.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_core_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_dbus.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_dbus_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_docgallery.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_docgallery_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_feedback.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_feedback_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_gui.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_gui_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_location.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_location_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_multimedia.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_multimedia_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_network.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_network_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_opengl.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_opengl_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_openglextensions.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_openglextensions_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_organizer.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_organizer_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_platformsupport_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_positioning.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_positioning_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfclient.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfclient_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfmessageserver.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfmessageserver_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qml.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qml_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_quick.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_quick_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_quickparticles_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sensors.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sensors_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sql.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sql_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_svg.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_svg_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versit.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versit_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versitorganizer.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versitorganizer_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_waylandclient.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_waylandclient_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_webkit.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_webkit_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_widgets.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_widgets_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xml.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xml_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xmlpatterns.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xmlpatterns_private.pri \
		/usr/share/qt5/mkspecs/features/qt_functions.prf \
		/usr/share/qt5/mkspecs/features/qt_config.prf \
		/usr/share/qt5/mkspecs/linux-g++/qmake.conf \
		/usr/share/qt5/mkspecs/features/spec_post.prf \
		/usr/share/qt5/mkspecs/features/exclusive_builds.prf \
		/usr/share/qt5/mkspecs/features/default_pre.prf \
		/usr/share/qt5/mkspecs/features/resolve_config.prf \
		/usr/share/qt5/mkspecs/features/default_post.prf \
		/usr/share/qt5/mkspecs/features/sailfishapp_i18n.prf \
		/usr/share/qt5/mkspecs/features/sailfishapp.prf \
		/usr/share/qt5/mkspecs/features/link_pkgconfig.prf \
		/usr/share/qt5/mkspecs/features/warn_on.prf \
		/usr/share/qt5/mkspecs/features/qt.prf \
		/usr/share/qt5/mkspecs/features/resources.prf \
		/usr/share/qt5/mkspecs/features/moc.prf \
		/usr/share/qt5/mkspecs/features/unix/opengl.prf \
		/usr/share/qt5/mkspecs/features/unix/thread.prf \
		/usr/share/qt5/mkspecs/features/file_copies.prf \
		/usr/share/qt5/mkspecs/features/testcase_targets.prf \
		/usr/share/qt5/mkspecs/features/exceptions.prf \
		/usr/share/qt5/mkspecs/features/yacc.prf \
		/usr/share/qt5/mkspecs/features/lex.prf \
		ek_viewer.pro  src/ek_viewer.cpp
QMAKE_TARGET  = ek_viewer
DESTDIR       = 
TARGET        = ek_viewer


first: all
####### Build rules

$(TARGET):  $(OBJECTS)  
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)

Makefile: ek_viewer.pro /usr/share/qt5/mkspecs/linux-g++/qmake.conf /usr/share/qt5/mkspecs/features/spec_pre.prf \
		/usr/share/qt5/mkspecs/common/unix.conf \
		/usr/share/qt5/mkspecs/common/linux.conf \
		/usr/share/qt5/mkspecs/common/sanitize.conf \
		/usr/share/qt5/mkspecs/common/gcc-base.conf \
		/usr/share/qt5/mkspecs/common/gcc-base-unix.conf \
		/usr/share/qt5/mkspecs/common/g++-base.conf \
		/usr/share/qt5/mkspecs/common/g++-unix.conf \
		/usr/share/qt5/mkspecs/qconfig.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_bluetooth.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_bluetooth_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_compositor.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_compositor_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_concurrent.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_concurrent_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_contacts.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_contacts_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_core.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_core_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_dbus.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_dbus_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_docgallery.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_docgallery_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_feedback.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_feedback_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_gui.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_gui_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_location.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_location_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_multimedia.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_multimedia_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_network.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_network_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_opengl.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_opengl_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_openglextensions.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_openglextensions_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_organizer.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_organizer_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_platformsupport_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_positioning.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_positioning_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfclient.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfclient_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfmessageserver.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qmfmessageserver_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qml.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qml_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_quick.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_quick_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_quickparticles_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sensors.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sensors_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sql.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_sql_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_svg.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_svg_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versit.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versit_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versitorganizer.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_versitorganizer_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_waylandclient.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_waylandclient_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_webkit.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_webkit_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_widgets.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_widgets_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xml.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xml_private.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xmlpatterns.pri \
		/usr/share/qt5/mkspecs/modules/qt_lib_xmlpatterns_private.pri \
		/usr/share/qt5/mkspecs/features/qt_functions.prf \
		/usr/share/qt5/mkspecs/features/qt_config.prf \
		/usr/share/qt5/mkspecs/linux-g++/qmake.conf \
		/usr/share/qt5/mkspecs/features/spec_post.prf \
		/usr/share/qt5/mkspecs/features/exclusive_builds.prf \
		/usr/share/qt5/mkspecs/features/default_pre.prf \
		/usr/share/qt5/mkspecs/features/resolve_config.prf \
		/usr/share/qt5/mkspecs/features/default_post.prf \
		/usr/share/qt5/mkspecs/features/sailfishapp_i18n.prf \
		/usr/share/qt5/mkspecs/features/sailfishapp.prf \
		/usr/share/qt5/mkspecs/features/link_pkgconfig.prf \
		/usr/share/qt5/mkspecs/features/warn_on.prf \
		/usr/share/qt5/mkspecs/features/qt.prf \
		/usr/share/qt5/mkspecs/features/resources.prf \
		/usr/share/qt5/mkspecs/features/moc.prf \
		/usr/share/qt5/mkspecs/features/unix/opengl.prf \
		/usr/share/qt5/mkspecs/features/unix/thread.prf \
		/usr/share/qt5/mkspecs/features/file_copies.prf \
		/usr/share/qt5/mkspecs/features/testcase_targets.prf \
		/usr/share/qt5/mkspecs/features/exceptions.prf \
		/usr/share/qt5/mkspecs/features/yacc.prf \
		/usr/share/qt5/mkspecs/features/lex.prf \
		ek_viewer.pro \
		/usr/lib/libQt5Quick.prl \
		/usr/lib/libQt5Gui.prl \
		/usr/lib/libQt5Qml.prl \
		/usr/lib/libQt5Network.prl \
		/usr/lib/libQt5Core.prl
	$(QMAKE) 'QMAKE_CFLAGS_RELEASE=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CFLAGS_DEBUG=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CXXFLAGS_RELEASE=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CXXFLAGS_DEBUG=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' QMAKE_STRIP=: PREFIX=/usr LIBDIR=/usr/lib -o Makefile ek_viewer.pro
/usr/share/qt5/mkspecs/features/spec_pre.prf:
/usr/share/qt5/mkspecs/common/unix.conf:
/usr/share/qt5/mkspecs/common/linux.conf:
/usr/share/qt5/mkspecs/common/sanitize.conf:
/usr/share/qt5/mkspecs/common/gcc-base.conf:
/usr/share/qt5/mkspecs/common/gcc-base-unix.conf:
/usr/share/qt5/mkspecs/common/g++-base.conf:
/usr/share/qt5/mkspecs/common/g++-unix.conf:
/usr/share/qt5/mkspecs/qconfig.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_bluetooth.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_bluetooth_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_compositor.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_compositor_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_concurrent.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_concurrent_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_contacts.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_contacts_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_core.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_core_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_dbus.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_dbus_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_docgallery.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_docgallery_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_feedback.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_feedback_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_gui.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_gui_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_location.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_location_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_multimedia.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_multimedia_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_network.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_network_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_opengl.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_opengl_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_openglextensions.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_openglextensions_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_organizer.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_organizer_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_platformsupport_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_positioning.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_positioning_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_qmfclient.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_qmfclient_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_qmfmessageserver.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_qmfmessageserver_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_qml.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_qml_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_qtmultimediaquicktools_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_quick.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_quick_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_quickparticles_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_sensors.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_sensors_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_sql.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_sql_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_svg.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_svg_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_versit.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_versit_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_versitorganizer.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_versitorganizer_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_waylandclient.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_waylandclient_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_webkit.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_webkit_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_widgets.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_widgets_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_xml.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_xml_private.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_xmlpatterns.pri:
/usr/share/qt5/mkspecs/modules/qt_lib_xmlpatterns_private.pri:
/usr/share/qt5/mkspecs/features/qt_functions.prf:
/usr/share/qt5/mkspecs/features/qt_config.prf:
/usr/share/qt5/mkspecs/linux-g++/qmake.conf:
/usr/share/qt5/mkspecs/features/spec_post.prf:
/usr/share/qt5/mkspecs/features/exclusive_builds.prf:
/usr/share/qt5/mkspecs/features/default_pre.prf:
/usr/share/qt5/mkspecs/features/resolve_config.prf:
/usr/share/qt5/mkspecs/features/default_post.prf:
/usr/share/qt5/mkspecs/features/sailfishapp_i18n.prf:
/usr/share/qt5/mkspecs/features/sailfishapp.prf:
/usr/share/qt5/mkspecs/features/link_pkgconfig.prf:
/usr/share/qt5/mkspecs/features/warn_on.prf:
/usr/share/qt5/mkspecs/features/qt.prf:
/usr/share/qt5/mkspecs/features/resources.prf:
/usr/share/qt5/mkspecs/features/moc.prf:
/usr/share/qt5/mkspecs/features/unix/opengl.prf:
/usr/share/qt5/mkspecs/features/unix/thread.prf:
/usr/share/qt5/mkspecs/features/file_copies.prf:
/usr/share/qt5/mkspecs/features/testcase_targets.prf:
/usr/share/qt5/mkspecs/features/exceptions.prf:
/usr/share/qt5/mkspecs/features/yacc.prf:
/usr/share/qt5/mkspecs/features/lex.prf:
ek_viewer.pro:
/usr/lib/libQt5Quick.prl:
/usr/lib/libQt5Gui.prl:
/usr/lib/libQt5Qml.prl:
/usr/lib/libQt5Network.prl:
/usr/lib/libQt5Core.prl:
qmake: FORCE
	@$(QMAKE) 'QMAKE_CFLAGS_RELEASE=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CFLAGS_DEBUG=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CXXFLAGS_RELEASE=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' 'QMAKE_CXXFLAGS_DEBUG=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -fmessage-length=0 -march=armv7-a -mfloat-abi=hard -mfpu=neon -mthumb -Wno-psabi' QMAKE_STRIP=: PREFIX=/usr LIBDIR=/usr/lib -o Makefile ek_viewer.pro

qmake_all: FORCE


all: Makefile $(TARGET)

dist: distdir FORCE
	(cd `dirname $(DISTDIR)` && $(TAR) $(DISTNAME).tar $(DISTNAME) && $(COMPRESS) $(DISTNAME).tar) && $(MOVE) `dirname $(DISTDIR)`/$(DISTNAME).tar.gz . && $(DEL_FILE) -r $(DISTDIR)

distdir: FORCE
	@test -d $(DISTDIR) || mkdir -p $(DISTDIR)
	$(COPY_FILE) --parents $(DIST) $(DISTDIR)/
	$(COPY_FILE) --parents src/ek_viewer.cpp $(DISTDIR)/
	$(COPY_FILE) --parents translations/ek_viewer-de.ts $(DISTDIR)/


clean: compiler_clean 
	-$(DEL_FILE) $(OBJECTS)
	-$(DEL_FILE) *~ core *.core


distclean: clean 
	-$(DEL_FILE) $(TARGET) 
	-$(DEL_FILE) Makefile


####### Sub-libraries

mocclean: compiler_moc_header_clean compiler_moc_source_clean

mocables: compiler_moc_header_make_all compiler_moc_source_make_all

check: first

benchmark: first

compiler_rcc_make_all:
compiler_rcc_clean:
compiler_moc_header_make_all:
compiler_moc_header_clean:
compiler_moc_source_make_all:
compiler_moc_source_clean:
compiler_yacc_decl_make_all:
compiler_yacc_decl_clean:
compiler_yacc_impl_make_all:
compiler_yacc_impl_clean:
compiler_lex_make_all:
compiler_lex_clean:
compiler_clean: 

####### Compile

ek_viewer.o: src/ek_viewer.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o ek_viewer.o src/ek_viewer.cpp

####### Install

install_qm: first FORCE
	@test -d $(INSTALL_ROOT)/usr/share/ek_viewer/translations || mkdir -p $(INSTALL_ROOT)/usr/share/ek_viewer/translations
	lupdate -noobsolete /home/sfos_app/ek_viewer/src /home/sfos_app/ek_viewer/qml -ts /home/sfos_app/ek_viewer/translations/ek_viewer.ts /home/sfos_app/ek_viewer/translations/ek_viewer-de.ts && mkdir -p translations && [ "/home/sfos_app/ek_viewer" != "/home/sfos_app/ek_viewer" -a 1 -eq 1 ] && cp -af /home/sfos_app/ek_viewer/translations/ek_viewer-de.ts /home/sfos_app/ek_viewer/translations || : ; [ 1 -eq 1 ] && lrelease -nounfinished /home/sfos_app/ek_viewer/translations/ek_viewer-de.ts || :
	-$(INSTALL_FILE) /home/sfos_app/ek_viewer/translations/ek_viewer-de.qm $(INSTALL_ROOT)/usr/share/ek_viewer/translations/

uninstall_qm: FORCE
	-$(DEL_FILE) -r $(INSTALL_ROOT)/usr/share/ek_viewer/translations/ek_viewer-de.qm
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/share/ek_viewer/translations/ 


install_qml: first FORCE
	@test -d $(INSTALL_ROOT)/usr/share/ek_viewer || mkdir -p $(INSTALL_ROOT)/usr/share/ek_viewer
	-$(INSTALL_DIR) /home/sfos_app/ek_viewer/qml $(INSTALL_ROOT)/usr/share/ek_viewer/

uninstall_qml: FORCE
	-$(DEL_FILE) -r $(INSTALL_ROOT)/usr/share/ek_viewer/qml
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/share/ek_viewer/ 


install_target: first FORCE
	@test -d $(INSTALL_ROOT)/usr/bin || mkdir -p $(INSTALL_ROOT)/usr/bin
	-$(INSTALL_PROGRAM) $(QMAKE_TARGET) $(INSTALL_ROOT)/usr/bin/$(QMAKE_TARGET)
	-$(STRIP) $(INSTALL_ROOT)/usr/bin/$(QMAKE_TARGET)

uninstall_target: FORCE
	-$(DEL_FILE) $(INSTALL_ROOT)/usr/bin/$(QMAKE_TARGET)
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/bin/ 


install_desktop: first FORCE
	@test -d $(INSTALL_ROOT)/usr/share/applications || mkdir -p $(INSTALL_ROOT)/usr/share/applications
	-$(INSTALL_FILE) /home/sfos_app/ek_viewer/ek_viewer.desktop $(INSTALL_ROOT)/usr/share/applications/

uninstall_desktop: FORCE
	-$(DEL_FILE) -r $(INSTALL_ROOT)/usr/share/applications/ek_viewer.desktop
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/share/applications/ 


install_icon86x86: first FORCE
	@test -d $(INSTALL_ROOT)/usr/share/icons/hicolor/86x86/apps || mkdir -p $(INSTALL_ROOT)/usr/share/icons/hicolor/86x86/apps
	-$(INSTALL_FILE) /home/sfos_app/ek_viewer/icons/86x86/ek_viewer.png $(INSTALL_ROOT)/usr/share/icons/hicolor/86x86/apps/

uninstall_icon86x86: FORCE
	-$(DEL_FILE) -r $(INSTALL_ROOT)/usr/share/icons/hicolor/86x86/apps/ek_viewer.png
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/share/icons/hicolor/86x86/apps/ 


install_icon108x108: first FORCE
	@test -d $(INSTALL_ROOT)/usr/share/icons/hicolor/108x108/apps || mkdir -p $(INSTALL_ROOT)/usr/share/icons/hicolor/108x108/apps
	-$(INSTALL_FILE) /home/sfos_app/ek_viewer/icons/108x108/ek_viewer.png $(INSTALL_ROOT)/usr/share/icons/hicolor/108x108/apps/

uninstall_icon108x108: FORCE
	-$(DEL_FILE) -r $(INSTALL_ROOT)/usr/share/icons/hicolor/108x108/apps/ek_viewer.png
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/share/icons/hicolor/108x108/apps/ 


install_icon128x128: first FORCE
	@test -d $(INSTALL_ROOT)/usr/share/icons/hicolor/128x128/apps || mkdir -p $(INSTALL_ROOT)/usr/share/icons/hicolor/128x128/apps
	-$(INSTALL_FILE) /home/sfos_app/ek_viewer/icons/128x128/ek_viewer.png $(INSTALL_ROOT)/usr/share/icons/hicolor/128x128/apps/

uninstall_icon128x128: FORCE
	-$(DEL_FILE) -r $(INSTALL_ROOT)/usr/share/icons/hicolor/128x128/apps/ek_viewer.png
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/share/icons/hicolor/128x128/apps/ 


install_icon172x172: first FORCE
	@test -d $(INSTALL_ROOT)/usr/share/icons/hicolor/172x172/apps || mkdir -p $(INSTALL_ROOT)/usr/share/icons/hicolor/172x172/apps
	-$(INSTALL_FILE) /home/sfos_app/ek_viewer/icons/172x172/ek_viewer.png $(INSTALL_ROOT)/usr/share/icons/hicolor/172x172/apps/

uninstall_icon172x172: FORCE
	-$(DEL_FILE) -r $(INSTALL_ROOT)/usr/share/icons/hicolor/172x172/apps/ek_viewer.png
	-$(DEL_DIR) $(INSTALL_ROOT)/usr/share/icons/hicolor/172x172/apps/ 


install: install_qm install_qml install_target install_desktop install_icon86x86 install_icon108x108 install_icon128x128 install_icon172x172  FORCE

uninstall: uninstall_qm uninstall_qml uninstall_target uninstall_desktop uninstall_icon86x86 uninstall_icon108x108 uninstall_icon128x128 uninstall_icon172x172  FORCE

FORCE:

