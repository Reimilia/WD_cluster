#include "global.h"
#include "stdafx.h"
using namespace std;


GlobalM::GlobalM()
{
}


GlobalM::~GlobalM()
{
	if (constraint_id_)
		delete []constraint_id_;
	constraint_id_ = NULL;
}

void GlobalM::Add_Constraint(int & index_,const int center_id_, const vector<size_t>neighbour_)
{
	/*
	Add linear constraint into the system
	*/


	for (int i = 0; i < neighbour_.size(); i++)
	{

		if (src_->get_vertex(neighbour_[i])->isOnBoundary())
		{
			b_(index_) += src_->get_vertex(neighbour_[i])->position().x();
			b_(index_+1) += src_->get_vertex(neighbour_[i])->position().y();
			b_(index_+2) += src_->get_vertex(neighbour_[i])->position().z();

		}
		else
		{
			A_(index_, 3*constraint_id_[neighbour_[i]]) = -1.0;
			A_(index_+1, 3*constraint_id_[neighbour_[i]]+1) = -1.0;
			A_(index_+2, 3*constraint_id_[neighbour_[i]]+2) = -1.0;
		}
	}

	A_(index_, index_) = neighbour_.size();
	A_(index_ + 1, index_ + 1) = neighbour_.size();
	A_(index_ + 2, index_ + 2) = neighbour_.size();
	index_ += 3;
}

void GlobalM::Assign_New_Position()
{
	//Solve the equation
	//and update the Mesh3D
	VectorXd answer_;
	Vec3f new_position_;

	answer_ = A_.lu().solve(b_);


	for (int i = 0; i < size_; i++)
	{
		new_position_[0] = answer_[3 * i];
		new_position_[1] = answer_[3 * i + 1];
		new_position_[2] = answer_[3 * i + 2];

		src_->get_vertex(inner_[i])->set_position(new_position_);
	}

	src_->UpdateMesh();
}


void GlobalM::Calculate()
{
	// Get Minimal Surface by solving a linear system

	size_ = src_->num_of_vertex_list();
	vector <size_t> neighbour_;
	constraint_id_ = new size_t[size_];

	int index_ = 0;

	// First Fix the bounary and find inner points (record the index of them)
	for (int i = 0; i < size_; i++)
	{
		if (!src_->get_vertex(i)->isOnBoundary())
		{
			inner_.push_back(i);
			constraint_id_[i] = index_++;
		}
	}

	size_ = inner_.size();
	A_.resize(3 * size_, 3 * size_);
	b_.resize(3 * size_);
	A_.setZero();
	b_.setZero();
	index_ = 0;

	for (int i = 0; i < size_; i++)
	{
		src_->get_neighborId(inner_[i], neighbour_);
		
		// Add constraint
		Add_Constraint(index_, inner_[i], neighbour_);		
		
	}
	
	//if (fabs(A_.determinant()) < 1e-5) return;

	// Solve equation and update
	Assign_New_Position();
}
