# Data
The main dataset used was surface current data from high-frequency radars set up and maintained by the Taiwan Ocean Research Institute.
The data period goes from 2013/1/1 to 2017/12/31 with hourly measurements on a 10km grid.
Additionally, ERA5 reanalysis wind data and CMEMS satellite derived geostrophic currents where downloaded for the same period.
They are on different 0.25° grids.
Wind data is hourly, while satellite data is daily.

# Methods
A couple different analysing techniques have been applied.

The main one was spectral analysis.
But as the CODAR data is not perfect and has some gaps, especially further away from the antennas, the fourier transformation became difficult.
Usually, spectral analysis has to be done on a uniform temporal grid without missing values.
But I did not want to perform any interpolation, because some gaps are quite large and linear interpolation would be just wrong.
Fitting another interpolation method is questionable as well.
Therefore, I used a technique called non-uniform discrete/fast fourier transformation, in which one sets the the time steps between each data point.
