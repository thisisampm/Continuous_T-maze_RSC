function plotsecratetrial(eptrials, cell, section)
%plotsecrate (eptrials, cell, section) barplots mean firing rate of a single 
% cell (cell) in a particular section of the maze (section) by trial type. 
% Correct trials only.
%
%eptrials is a matrix generated by the function 'trials'
%
%cell is the sorted cluster number.
%
%section input should be FOLDED SECTION as follows:
%  1 = start area 
%  2 = low stem 
%  3 = high stem
%  4 = choice area 
%  5 = choice arm (both)
%  6 = reward area (both)
%  7 = return arm (both)  

smplrt=length(eptrials(isnan(eptrials(:,4)),1))/max(eptrials(:,1));

figure

%(rates, trialtype)
trialrates = NaN(max(eptrials(:,5))-1, 2);

%firing rate and trialtype for each trial

for trl = 2:max(eptrials(:,5))
    
    if mode(eptrials(eptrials(:,5)==trl,8))==1
    
        %this if statement accounts for the "both"s in the section input
        if ismember(section, 1:4)
        
            %how many spikes(c) occured on the section(s) on trial(trl) 
            spikes = length(eptrials(eptrials(:,4)==cell & eptrials(:,5)==trl & eptrials(:,6)==section,4));
    
            %how long was spent on section(s) on trial(trl)
            time = length(eptrials(eptrials(:,5)==trl & eptrials(:,6)==section & isnan(eptrials(:,4)), 1))/smplrt;
    
            rate = spikes/time;
    
            trialrates(trl, 1) = rate;
            trialrates(trl, 2) = mode(eptrials(eptrials(:,5)==trl, 7));

        elseif section == 5
        
            %how many spikes(c) occured on the section(s) on trial(trl) 
            spikes = length(eptrials(eptrials(:,4)==cell & eptrials(:,5)==trl & eptrials(:,6)>4 & eptrials(:,6)<7,4));
    
            %how long was spent on section(s) on trial(trl)
            time = length(eptrials(eptrials(:,5)==trl & eptrials(:,6)>4 & eptrials(:,6)<7 & isnan(eptrials(:,4)), 1))/smplrt;
    
            rate = spikes/time;
    
            trialrates(trl, 1) = rate;
            trialrates(trl, 2) = mode(eptrials(eptrials(:,5)==trl, 7));
            
        elseif section == 6
        
            %how many spikes(c) occured on the section(s) on trial(trl) 
            spikes = length(eptrials(eptrials(:,4)==cell & eptrials(:,5)==trl & eptrials(:,6)>6 & eptrials(:,6)<9,4));
    
            %how long was spent on section(s) on trial(trl)
            time = length(eptrials(eptrials(:,5)==trl & eptrials(:,6)>6 & eptrials(:,6)<9 & isnan(eptrials(:,4)), 1))/smplrt;    
    
            rate = spikes/time;
    
            trialrates(trl, 1) = rate;
            trialrates(trl, 2) = mode(eptrials(eptrials(:,5)==trl, 7));

        elseif section == 7
        
            %how many spikes(c) occured on the section(s) on trial(trl) 
            spikes = length(eptrials(eptrials(:,4)==cell & eptrials(:,5)==trl & eptrials(:,6)>8,4));
    
            %how long was spent on section(s) on trial(trl)
            time = length(eptrials(eptrials(:,5)==trl & eptrials(:,6)>8 & isnan(eptrials(:,4)), 1))/smplrt;    
    
            rate = spikes/time;
    
            trialrates(trl, 1) = rate;
            trialrates(trl, 2) = mode(eptrials(eptrials(:,5)==trl, 7));   
    
        end
            
    else %NaNs for the incorrect trials. We will continue to ignore them below.
        
        trialrates(trl, 1) = NaN;
        trialrates(trl, 2) = NaN;
        
    end
end

%calculating means
leftmean=nanmean(trialrates(trialrates(:,2)==1, 1));
rightmean=nanmean(trialrates(trialrates(:,2)==2, 1));
leftstd=nanstd(trialrates(trialrates(:,2)==1, 1));
rightstd=nanstd(trialrates(trialrates(:,2)==2, 1));
leftlen=sum(~isnan(trialrates(trialrates(:,2)==1, 1)));
rightlen=sum(~isnan(trialrates(trialrates(:,2)==2, 1)));

means=[leftmean, rightmean];
N=[leftlen, rightlen];
error=[leftstd./sqrt(N(1)), rightstd./sqrt(N(2))];

%plotting with barweb, a function downloaded from the internet that adds
%errorbars to barplots
barweb(means, error, .80);

grn=[52 153 70]./255;
blu=[46 49 146]./255;

b=get(gca, 'Children');
set(b(3), 'FaceColor', blu)
set(b(4), 'FaceColor', grn) 
set(gca,'FontSize',15)
set(gca,'LineWidth', 1)

%lables
ylabel('Mean Firing Rate (Hz)', 'fontsize', 20)
set(gca, 'Xtick', 0.850:0.30:1.150,'XTickLabel',{'Left', 'Right'}, 'fontsize', 20)
