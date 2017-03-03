/****************************************************************************
** Meta object code from reading C++ file 'renderwidget.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "stdafx.h"
#include "../../renderwidget.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'renderwidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.6.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_RenderWidget_t {
    QByteArrayData data[16];
    char stringdata0[177];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_RenderWidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_RenderWidget_t qt_meta_stringdata_RenderWidget = {
    {
QT_MOC_LITERAL(0, 0, 12), // "RenderWidget"
QT_MOC_LITERAL(1, 13, 8), // "meshInfo"
QT_MOC_LITERAL(2, 22, 0), // ""
QT_MOC_LITERAL(3, 23, 12), // "operatorInfo"
QT_MOC_LITERAL(4, 36, 13), // "SetBackground"
QT_MOC_LITERAL(5, 50, 8), // "ReadMesh"
QT_MOC_LITERAL(6, 59, 9), // "WriteMesh"
QT_MOC_LITERAL(7, 69, 11), // "LoadTexture"
QT_MOC_LITERAL(8, 81, 14), // "CheckDrawPoint"
QT_MOC_LITERAL(9, 96, 2), // "bv"
QT_MOC_LITERAL(10, 99, 13), // "CheckDrawEdge"
QT_MOC_LITERAL(11, 113, 13), // "CheckDrawFace"
QT_MOC_LITERAL(12, 127, 10), // "CheckLight"
QT_MOC_LITERAL(13, 138, 16), // "CheckDrawTexture"
QT_MOC_LITERAL(14, 155, 13), // "CheckDrawAxes"
QT_MOC_LITERAL(15, 169, 7) // "Restore"

    },
    "RenderWidget\0meshInfo\0\0operatorInfo\0"
    "SetBackground\0ReadMesh\0WriteMesh\0"
    "LoadTexture\0CheckDrawPoint\0bv\0"
    "CheckDrawEdge\0CheckDrawFace\0CheckLight\0"
    "CheckDrawTexture\0CheckDrawAxes\0Restore"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_RenderWidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    3,   79,    2, 0x06 /* Public */,
       3,    1,   86,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    0,   89,    2, 0x0a /* Public */,
       5,    0,   90,    2, 0x0a /* Public */,
       6,    0,   91,    2, 0x0a /* Public */,
       7,    0,   92,    2, 0x0a /* Public */,
       8,    1,   93,    2, 0x0a /* Public */,
      10,    1,   96,    2, 0x0a /* Public */,
      11,    1,   99,    2, 0x0a /* Public */,
      12,    1,  102,    2, 0x0a /* Public */,
      13,    1,  105,    2, 0x0a /* Public */,
      14,    1,  108,    2, 0x0a /* Public */,
      15,    0,  111,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int,    2,    2,    2,
    QMetaType::Void, QMetaType::QString,    2,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,    9,
    QMetaType::Void, QMetaType::Bool,    9,
    QMetaType::Void, QMetaType::Bool,    9,
    QMetaType::Void, QMetaType::Bool,    9,
    QMetaType::Void, QMetaType::Bool,    9,
    QMetaType::Void, QMetaType::Bool,    9,
    QMetaType::Void,

       0        // eod
};

void RenderWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        RenderWidget *_t = static_cast<RenderWidget *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->meshInfo((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 1: _t->operatorInfo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->SetBackground(); break;
        case 3: _t->ReadMesh(); break;
        case 4: _t->WriteMesh(); break;
        case 5: _t->LoadTexture(); break;
        case 6: _t->CheckDrawPoint((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 7: _t->CheckDrawEdge((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 8: _t->CheckDrawFace((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 9: _t->CheckLight((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 10: _t->CheckDrawTexture((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 11: _t->CheckDrawAxes((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 12: _t->Restore(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (RenderWidget::*_t)(int , int , int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&RenderWidget::meshInfo)) {
                *result = 0;
            }
        }
        {
            typedef void (RenderWidget::*_t)(QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&RenderWidget::operatorInfo)) {
                *result = 1;
            }
        }
    }
}

const QMetaObject RenderWidget::staticMetaObject = {
    { &QGLWidget::staticMetaObject, qt_meta_stringdata_RenderWidget.data,
      qt_meta_data_RenderWidget,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *RenderWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *RenderWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_RenderWidget.stringdata0))
        return static_cast<void*>(const_cast< RenderWidget*>(this));
    return QGLWidget::qt_metacast(_clname);
}

int RenderWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QGLWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 13)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 13;
    }
    return _id;
}

// SIGNAL 0
void RenderWidget::meshInfo(int _t1, int _t2, int _t3)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void RenderWidget::operatorInfo(QString _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
