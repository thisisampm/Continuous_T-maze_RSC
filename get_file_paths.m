function item_paths = get_file_paths(fpath)
%iterates through each folder in path and returns path incl folder

item_paths = cell(1);

%items in path
file_list = dir(fpath);
for iitem = 1:length(file_list)
    current_sesh = file_list(iitem).name;
    
    %omited folder and file names (folders named 'old' are invisible)
    if strcmp(current_sesh, '.') || strcmp(current_sesh, '..') || strcmp(current_sesh, 'old')
        continue
    end

    if isfolder([fpath '\' file_list(iitem).name])
        item_paths_hold = get_file_paths([fpath '\' file_list(iitem).name]);
        item_paths = [item_paths; item_paths_hold];
    elseif isfile([fpath '\' file_list(iitem).name])
        item_paths = [item_paths; {[fpath '\' file_list(iitem).name]}];
    end

end

%remove empty cells
item_paths = item_paths(find(~cellfun(@isempty, item_paths)));
end

