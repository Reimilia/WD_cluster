/********************************************************************************
** Form generated from reading UI file 'renderwidget.ui'
**
** Created by: Qt User Interface Compiler version 5.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_RENDERWIDGET_H
#define UI_RENDERWIDGET_H

#include <QtCore/QVariant>
#include <QtOpenGL/QGLWidget>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHeaderView>

QT_BEGIN_NAMESPACE

class Ui_RenderWidget
{
public:

    void setupUi(QGLWidget *RenderWidget)
    {
        if (RenderWidget->objectName().isEmpty())
            RenderWidget->setObjectName(QStringLiteral("RenderWidget"));
        RenderWidget->resize(400, 300);

        retranslateUi(RenderWidget);

        QMetaObject::connectSlotsByName(RenderWidget);
    } // setupUi

    void retranslateUi(QGLWidget *RenderWidget)
    {
        RenderWidget->setWindowTitle(QApplication::translate("RenderWidget", "RenderWidget", 0));
    } // retranslateUi

};

namespace Ui {
    class RenderWidget: public Ui_RenderWidget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_RENDERWIDGET_H
