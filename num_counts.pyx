'''
__license__   = "GNU GPLv3 <https://www.gnu.org/licenses/gpl.txt>"
__copyright__ = "2016, Joseph Kuruvilla"
__author__    = "Joseph Kuruvilla <joseph.k@uni-bonn.de>"
__version__   = "1.0"

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''

# --------------------
# Importing modules
# --------------------

from libc.math cimport sqrt

import numpy as np
cimport numpy as np
from numpy cimport ndarray
from numpy cimport int

DTYPEf = np.float32
ctypedef np.float32_t DTYPEf_t

DTYPEff = np.int64
ctypedef  np.int64_t DTYPEff_t

cimport cython


# --------------------
# Defining functions
# --------------------

@cython.boundscheck(False)
@cython.wraparound(False)

def DD_1d(np.ndarray[DTYPEf_t, ndim=2] data, int lower_index, int upper_index, float width, int num_bins, int num_particles):
  '''
  Function to find the 1D data-data average
  '''
  cdef: # declaring c types for our variables
    float distance = 0.0
    ndarray[DTYPEf_t, ndim=1] counter = np.zeros(num_bins, dtype=np.float32)
    Py_ssize_t i, j
    int binn

  for i in range(lower_index, upper_index):
    for j in range(i+1, num_particles):
      distance = sqrt(((data[j,0]-data[i,0])*(data[j,0]-data[i,0]))+((data[j,1]-data[i,1])*(data[j,1]-data[i,1]))+((data[j,2]-data[i,2])*(data[j,2]-data[i,2])))
      binn = int(distance//width)
      counter[binn] += 1

  return counter
