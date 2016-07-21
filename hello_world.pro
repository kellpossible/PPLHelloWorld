TEMPLATE = lib
QT -= gui core

#CONFIG += warn_on plugin release
#CONFIG -= thread exceptions qt rtti debug
CONFIG += warn_on plugin debug
CONFIG -= thread exceptions qt rtti

VERSION = 1.0.0

INCLUDEPATH += ../SDK/CHeaders/XPLM
INCLUDEPATH += ../SDK/CHeaders/Wrappers
INCLUDEPATH += ../SDK/CHeaders/Widgets

# Defined to use X-Plane SDK 2.0 capabilities - no backward compatibility before 9.0
DEFINES += XPLM200
DEFINES += PRIVATENAMESPACE=HELLOWORLD

win32 {
DEFINES += APL=0 IBM=1 LIN=0
LIBS += -L../SDK/Libraries/Win
LIBS += -lXPLM -lXPWidgets
TARGET = win.xpl
}

unix:!macx {
DEFINES += APL=0 IBM=0 LIN=1
TARGET = lin.xpl
# WARNING! This requires the latest version of the X-SDK !!!!
QMAKE_CXXFLAGS += -fvisibility=hidden
}

macx {
DEFINES += APL=1 IBM=0 LIN=0
TARGET = mac.xpl
QMAKE_LFLAGS += -flat_namespace -undefined suppress

# Build for multiple architectures.
# The following line is only needed to build universal on PPC architectures.
# QMAKE_MAC_SDK=/Developer/SDKs/MacOSX10.4u.sdk
# The following line defines for which architectures we build.
CONFIG += x86 ppc
}

CONFIG( debug, debug|release ) {
    QMAKE_CXXFLAGS += -g
} else {
    DEFINES += NDEBUG
}

HEADERS += \
 XPLMDisplay.h \
 XPLMGraphics.h \
 dataref.h

SOURCES += \
hello_world.cpp


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../PPL/libHELLOWORLD/release/ -lppl
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../PPL/libHELLOWORLD/debug/ -lppl
else:unix: LIBS += -L$$PWD/../PPL/libHELLOWORLD/ -lppl

INCLUDEPATH += $$PWD/../PPL/libHELLOWORLD \
 $$PWD/../PPL/src \
 $$PWD/../PPL/include/simpleini

DEPENDPATH += $$PWD/../PPL/libHELLOWORLD \
 $$PWD/../PPL/src \
 $$PWD/../PPL/include/simpleini


win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../PPL/libHELLOWORLD/release/libppl.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../PPL/libHELLOWORLD/debug/libppl.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../PPL/libHELLOWORLD/release/ppl.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../PPL/libHELLOWORLD/debug/ppl.lib
else:unix: PRE_TARGETDEPS += $$PWD/../PPL/libHELLOWORLD/libppl.a
