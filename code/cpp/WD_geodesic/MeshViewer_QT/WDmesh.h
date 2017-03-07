#pragma once

#ifndef WDMESH
#define WDMESH

#include "stdafx.h"
#include <OpenMesh\Core\Mesh\TriMeshT.hh>
#include <OpenMesh\Tools\Smoother\smooth_mesh.hh>
#include <OpenMesh\Core\Geometry\VectorT.hh>
#include <OpenMesh\Core\Mesh\TriMesh_ArrayKernelT.hh>

class WDmesh
{
public:
	WDmesh();
	~WDmesh();
};

#endif  //WDMESH