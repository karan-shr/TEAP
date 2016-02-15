%> @file Signal_filter1_low_mean.m
%> @brief Filters the signal with a low pass mean filtering

%> @param  Signal: the signal to filter. Not a bulk signal !
%> @param windowSize: the window size (in samples)

%> @retval Signal: the newly filtered signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal_filter1_low_mean(Signal, windowSize)

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal_filter1_low_mean(Signal, windowSize)');
end

Signal__assert_mine(Signal);


raw = Signal__get_raw(Signal);

filtAvgEls = ones(1, windowSize)/windowSize;
raw = filtfilt(filtAvgEls, 1, [repmat(raw(1), windowSize, 1); raw']);

raw = raw';

%take out first second
offset = windowSize + 1;
raw = raw(offset:end);
%and say that the signal was offseted by offset frames
Signal = Signal__set_offset(Signal, Signal__get_offset(Signal) + offset);

Signal = Signal__set_raw(Signal, raw);

%Indicate that the signal has been filtered
Signal = Signal__set_preproc_lowpass(Signal);

