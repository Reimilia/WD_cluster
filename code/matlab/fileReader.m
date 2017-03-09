function [F,V] = fileReader(fileName)

[pathstr,name,ext] = fileparts(fileName);


if(strcmpi(ext,'.off') == 1)
    [F,V] = offRead(fileName);
end

if(strcmpi(ext,'.obj') == 1)
     [F,V] = objRead(fileName);
end

end