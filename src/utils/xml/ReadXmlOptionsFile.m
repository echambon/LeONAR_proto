function options = ReadXmlOptionsFile(filepath)
%READXMLOPTIONSFILE Summary of this function goes here
%   Detailed explanation goes here

try
    DOMnode	= xmlread(filepath);
    options	= ChildrenToStruct(DOMnode);
    
catch
    % File not found, returns empty structure
    options = struct();
end

end

function test_out = ChildrenToStruct(node,node_struct_in,last_field)

tmp_node_struct = struct();
if nargin >= 2
    tmp_node_struct = node_struct_in;
end
tmp_last_field  = '';
if nargin >= 3
    tmp_last_field = last_field;
end

if node.hasChildNodes
    childNodes = node.getChildNodes;
    
    for ii = 1:childNodes.getLength
        childNode = childNodes.item(ii-1);

        if strcmp(childNode.getNodeName,'item') && any(strcmp(methods(childNode), 'getAttribute'))
            fieldString = char(childNode.getAttribute('option'));
            if ~isempty(fieldString)
                textContent = char(childNode.getTextContent);
                tmp_node_struct.(fieldString) = textContent;
                tmp_last_field = fieldString;
            end
        end

        test_out = ChildrenToStruct(childNode,tmp_node_struct,tmp_last_field);
    end
else
    test_out = tmp_node_struct;
end

end