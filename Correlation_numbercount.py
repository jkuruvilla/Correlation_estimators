__license__   = "GNU GPLv3 <https://www.gnu.org/licenses/gpl.txt>"
__copyright__ = "2016, Joseph Kuruvilla"
__author__    = "Joseph Kuruvilla <joseph.k@uni-bonn.de>"
__version__   = "1.0"

'''
Program to determine the correlation function using Landy-Szalay estimator

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

# ------------------
# Importing Modules
# ------------------

import numpy as np
import h5py
from ConfigParser import SafeConfigParser
import num_counts as nc

# -------------------
# Config file reader
# -------------------

parser = SafeConfigParser()
parser.read('config.ini')
# Uses the read() method of SafeConfigParser to read the config file.

# --------------------
#   Program  start
# --------------------

if __name__ == "__main__":

  input_file = parser.get('input','file')            # input file is read from config file
  snap = h5py.File(input_file ,'r')

  head = snap["Header"]                              # reads header of the hdf5 file
  num_particles = head.attrs.get('NumPart_Total')[1] # 1 - Halo type particles, refer GADGET
                                                     # user guide for more details.
  pos = snap["/PartType1/Coordinates"][:]            # returns the positions of the particles

  boxsize = int(parser.get('input', 'box_length'))   # boxsize in Mpc
  bin_width = 0.5                                    # width of the bin
  radial_bins = np.arange(0, boxsize, bin_width)     # defining the radial bins
  n_bins = len(radial_bins)

  DD = nc.DD_1d(pos, 0, num_particles, bin_width, n_bins, num_particles)
