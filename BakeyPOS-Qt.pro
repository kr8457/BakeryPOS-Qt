QT       += core gui widgets qml quick sql quickwidgets
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

SOURCES += \
    Login.cpp \
    main.cpp \
    mainform.cpp

HEADERS += \
    Login.h \
    mainform.h

FORMS += \
    Login.ui \
    mainform.ui

RESOURCES += resources.qrc
DISTFILES += \
    Cashier.qml
