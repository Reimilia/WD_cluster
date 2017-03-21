#pragma once

#include "stdafx.h"
#include "renderwidget.h"
#include <QtWidgets/QMainWindow>
#include "ui_meshviewer.h"


class QLabel;
class QPushButton;
class QCheckBox;
class QGroupBox;
class RenderWidget;

class MeshViewer : public QMainWindow
{
	Q_OBJECT

public:
	MeshViewer(QWidget *parent = Q_NULLPTR);
	~MeshViewer();

private:
	void CreateActions();
	void CreateMenus();
	void CreateToolBars();
	void CreateStatusBar();
	void CreateRenderGroup();

protected:
	void keyPressEvent(QKeyEvent *e);
	void keyReleaseEvent(QKeyEvent *e);


	public slots:
	void ShowMeshInfo(int npoint, int nedge, int nface);
	void OpenFile();
	void ShowAbout();

private:
	Ui::MeshViewerClass ui;

	// Basic
	QMenu							*menu_file_;
	QMenu							*menu_edit_;
	QMenu							*menu_help_;
	QToolBar						*toolbar_file_;
	QToolBar						*toolbar_edit_;
	QToolBar						*toolbar_basic_;
	QAction							*action_new_;
	QAction							*action_open_;
	QAction							*action_save_;
	QAction							*action_saveas_;

	QAction							*action_aboutqt_;
	QAction							*action_about_;

	QAction							*action_restore_;
	// Basic Operator Tool
	QAction							*action_loadmesh_;
	QAction							*action_loadtexture_;
	QAction							*action_background_;
	QAction							*action_projection_depth_;

	// Render RadioButtons
	QCheckBox						*checkbox_point_;
	QCheckBox						*checkbox_edge_;
	QCheckBox						*checkbox_face_;
	QCheckBox						*checkbox_light_;
	QCheckBox						*checkbox_texture_;
	QCheckBox						*checkbox_axes_;

	QGroupBox						*groupbox_render_;

	//Spectral Laplacian Meshes Compression
	//QAction							*render_colormap_;
	//QLabel							*label_k_;
	//QLineEdit						*blank_k_;
	//QAction							*begin_compression_;


	//QGroupBox						*groupbox_spectral_;

	// Information
	QLabel							*label_meshinfo_;
	QLabel							*label_operatorinfo_;

	RenderWidget					*renderingwidget_;
};
