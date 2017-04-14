function v = get_options(options, name, v, mendatory)


if nargin<3
    error('Not enough arguments.');
end
if nargin<4
    mendatory = 0;
end

if isfield(options, name)
    v = eval(['options.' name ';']);
elseif mendatory
    error(['You have to provide options.' name '.']);
end 