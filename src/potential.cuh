/*
    Copyright 2017 Zheyong Fan, Ville Vierimaa, Mikko Ervasti, and Ari Harju
    This file is part of GPUMD.
    GPUMD is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    GPUMD is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with GPUMD.  If not, see <http://www.gnu.org/licenses/>.
*/


#pragma once
#include "box.cuh"
#include "gpu_vector.cuh"
#include "neighbor.cuh"


class Potential
{
public:
    int N1; int N2;
    double rc; // maximum cutoff distance
    Potential(void);
    virtual ~Potential(void);

    virtual void compute
    (
        const int type_shift,
        const Box& box,
        const Neighbor& neighbor,
        const GPU_Vector<int>& type,
        const GPU_Vector<double>& position,
        GPU_Vector<double>& potential,
        GPU_Vector<double>& force,
        GPU_Vector<double>& virial
    ) = 0;

protected:
    void find_properties_many_body
    (
        const Box& box,
        const int* NN,
        const int* NL,
        const double* f12x,
        const double* f12y,
        const double* f12z,
        const GPU_Vector<double>& position_per_atom,
        GPU_Vector<double>& force_per_atom,
        GPU_Vector<double>& virial_per_atom
    );
};


