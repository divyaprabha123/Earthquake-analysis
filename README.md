# Earthquake-analysis

APPLICATION OF ARIMA AND SPECTRAL ANALYSIS FOR PREDICTING EARTHQUAKES

An earthquake (also known as a quake, tremor or temblor) is the shaking of the surface of the Earth, resulting from the sudden release of energy in the Earth’s lithosphere that creates seismic waves.

Earthquake prediction is an immature science,it has not yet led to a successful prediction of an earthquake from first physical principles. Research into methods of prediction therefore focus on empirical analysis, with two general approaches: either identifying distinctive precursors to earthquakes, or identifying some kind of geophysical trend or pattern in seismicity that might precede a large earthquake. 

Earth Quake causes massive damages to both property and life. The prediction of earthquake may help in preventive measures. Earth quake prediction is a challenging task. When viewed as a time series data it forms a complex pattern consisting mixture of Statistical features. So, ARIMA and Spectral analysis techniques are applied in this work to improve the prediction accuracy.

I have chosen ARIMA Models to test the predicted value as it gives more weightage to the recent data 
In every work that has been done so far related to Earth Prediction have not considered the Earth quake Magnitudes as “Periods” and converted them to Spectrums(Single and Cross) for Analysis,

1. To build ARIMA model for forecasting the occurrence of earthquakes. Techniques like Auto regressive, moving average, ACF and PACF ARIMA models are applied.

2. Spectral analysis and filtering technique are used to predict the period of occurrence of the earthquakes. In this, spectrum and cross spectrum of different earth quake time series which uses the past data to forecast the future.

Spectral Analysis

Decomposition of time series into underlying sine and cosine at different frequencies which allows to determine those frequencies that appear particularly strong or important
Any time series can be expressed as a combination of cosine waves with differing periods and amplitudes .This fact can be utilized to examine the periodic (cyclical) behavior in a time series.
A periodogram is used to identify the dominant periods (or frequencies) of a time series.    Particularly when the cycles are not related to the commonly encountered monthly or quarterly seasonality.

The periodogram graphs a measure of the relative importance of possible frequency values that might explain the oscillation pattern of the observed data.
                                  x(t)=∑  [β1(j/n)cos(2πω(j)t)+β2(j/n)sin(2πω(j)t)]. Where j=1 to n/2

We have n data points and n parameters, so the fit of this regression model will be exact.The first step in the creation of the periodogram is the estimation of the β1(j/n) and β2(j/n) parameters.
 After the parameters have been estimated, we define
                                       P(j/n)=β1^2(j/n)+β2^2(j/n)
 
Fast Fourier Transform is used to compute these parameters
