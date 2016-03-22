'''
__license__   = "GNU GPLv3 <https://www.gnu.org/licenses/gpl.txt>"
__copyright__ = "2016, Joseph Kuruvilla"
__author__    = "Joseph Kuruvilla <joseph.k@uni-bonn.de>"
__version__   = "3.0"

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

cimport numpy as np

DTYPEf = np.float64
ctypedef np.float64_t DTYPEf_t

DTYPEi = np.int32
ctypedef  np.int32_t DTYPEi_t

cimport cython

@cython.boundscheck(False)
@cython.wraparound(False)


# --------------------
# Defining functions
# --------------------

def DD_1d(np.ndarray[DTYPEf_t, ndim=3] data, int lower_index, int upper_index, float width, int num_bins, int num_particles):
  '''
  Function to find the 1D data-data average
  '''
  cdef: # declaring c types for our variables
    float distance = 0.0
    np.ndarray[DTYPEi_t, ndim=1] counter = np.empty(num_bins, dtype=np.int32)
    int i, j, bin

  for i in range(lower_index, upper_index):
    for j in range(i+1, num_particles):
      distance = sqrt(((pos[j][0]-pos[i][0])*(pos[j][0]-pos[i][0]))+((pos[j][1]-pos[i][1])*(pos[j][1]-pos[i][1]))+((pos[j][2]-pos[i][2])*(pos[j][2]-pos[i][2])))
      bin = np.int(distance//width)
      counter[bin] += 1

  return counter
