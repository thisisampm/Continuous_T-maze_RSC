function [spike_counts] = slide_rate_window(eptrials, clusters, window_duration)
% moves through session fiding spike counts for each window of
% window_duration (no overlap) and recording the context from which it came
%
% window_duration is in seconds
%
% intended to be called iteratively, once for each unique context, although
% could be called all at once
%
% this function was written to do a context discrimination analysis
% 
% trial_id_info contains current trial type (L/R), correct/error, and
% window count
%

%hardish coded
delay_length = 30; %seconds

%find times surrounding each bin
all_time_bins = (max(eptrials(:,1))-delay_length):window_duration:max(eptrials(:,1));
time_bins_low = all_time_bins(1:(end-1));
time_bins_hi = all_time_bins(2:end);

%preallocate
spike_counts = nan(length(time_bins_low), size(clusters,1));

%iterate through time windows and count spikes
for wi = 1:length(time_bins_low)
    
    time_low = time_bins_low(wi);
    time_hi = time_bins_hi(wi);
    time_idx = eptrials(:,1)>=time_low & eptrials(:,1)<time_hi;
    
    %load spike_counts
    spike_counts(wi,:) = histcounts(eptrials(time_idx,4), [clusters(:,1); clusters(end,1)+.01]);

end

%spike_counts = spike_counts((end - delay_length/window_duration + 1):end,:);


end