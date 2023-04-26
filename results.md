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
Therefore, I used a technique called non-uniform discrete/fast fourier transformation (NUFFT), in which one gives the algorithm the time steps between each data point, which can vary.
Before performing the NUFFT, the data has been demeaned and detrended.
No window function has been applied, because it would remove amplitude necessary for the later performed reconstruction of the time series from the frequency domain.
Because of handling velocity data, the u and v components where combined in the complex plane as u = u + iv.
This has been used for the NUFFT.

Based on the spectral analysis, a peak finding method has been used to check if there is a peak in a certain frequency range.
If so, the amplitude and frequency of the peak were extracted.
Spectral ellipses have been calculated using these to investigate the spatial difference in importance of certain frequencies.
This was done based on formulas from [Walden2013](https://doi.org/10.1098/rsta.2011.0554).
The main interest was on the tidal signal, while also considering the coriolis frequency and the seasonal variation.

Time Filtering has been applied to remove the tidal signal from the data.
For this, a Butterworth window with a cut-off frequency of 1/40 cph and order 10 has been applied to the frequency amplitudes.
An inverse NUFFT has been performed on these filtered frequencies to reconstruct the time series.

Three sections have been extracted in the Taiwan Strait to investigate the throughflow and its temporal variability.
Sections were defined based on a start and end latitude and then, the closest points to this section extracted.
This can result in a staircase like structure.
Furthermore, velocity components have been rotated according to the section to end up with an along-section and cross-section velocity.

An EOF analysis has been done for the Taiwan Strait.
Points were this were selected using a mask.
Missing values have been set to zero, otherwise, the algorithm does not work.

For the comparison of surface currents to wind and geostrophic flow, the codar data has been averaged onto the coarser grid of the geostrophic velocities.
As the wind and geostrophic grid had not the same points while having the same resolution, the wind has been regridded as well.

A vector cross-correlation technique has been applied to investigate the relation of radar-derived flow to surface windstress and geostrophic currents.
The method is precisely described in the paper from [Kundu1976](https://doi.org/10.1175/1520-0485(1976)006%3C0238:EVONTO%3E2.0.CO;2).
It basically computes a correlation coeffient as well as the average veering angle between the two vectors over time.
Confidence levels for this calculation were calculated using a bootstrap approach.
Applied was a mooving bootstrap window of size 24 to resample the data.
Vector cross-correlation has been performed on the resample.
10000 replications of this lead to a distribution of the the correlation and the veering angle.
Upper and lower confidence levels were calculated with a simple percentile method for the 2.5% and 97.5% percentile to end up with a 95% confidence level.

I tried to calculate the significance of the correlation by applying a permutation test.
But random permutations on a time-series is not that valid, because the samples are not independant.
So I did not finish this approach.

Coherence between the surface currents and wind as well as geostrophic flow has been calculated.
This has been done by applying Welch's wethod and the NUFFT to extract cross-spectra.
For codar-wind a window size of 512 has been used.
As the geostrophic flow is only daily, surface currents have been daily averaged.
Then, because of way less data points, the window size has been reduced to 128.

I applied a lagrangian particle tracking method, [oceanparcels](https://oceanparcels.org/).
This works quite nicely, but has not been used for the analysis because lack of time and not having a specific approach.
An idea could be to release particles in the Penghu-channel each day and track them for a month or so to end up with a distribution of tracks in the Taiwan Strait.

# Results
## Data Coverage

<img src="./figures/data_coverage.png"  width=50% height=50%>

The data coverage for the investigated period is quite good around the whole island.
It is best in the Southeast, while being above 80% is the Taiwan Strait.
Therefore, the data allows reliable analysis.
Of course one has to keep the data coverage in mind before interpreting too much.
All analysis have been performed for each data point regardless of its coverage, so this point is especially important.

<img src="./figures/spectrum_example.png"  width=50% height=50%>

As on can see in this example of the powerspectrum from the NUFFT for the u component in the Taiwan Strait, the method works quite nicely.
