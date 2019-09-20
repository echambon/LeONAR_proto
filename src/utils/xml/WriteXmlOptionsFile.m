function WriteXmlOptionsFile(path,options)
%WRITEXMLOPTIONSFILE Summary of this function goes here
%   Detailed explanation goes here

t_path = path;
if ~strcmp(t_path(end),filesep)
    t_path = [t_path filesep];
end

docNode = com.mathworks.xml.XMLUtils.createDocument('options');
optionsElement = docNode.getDocumentElement;

optionsFieldnames = fieldnames(options);
for ii = 1:numel(optionsFieldnames)
    optionItem = docNode.createElement('item');
    optionItem.setAttribute('option',optionsFieldnames{ii});
    optionValue = options.(optionsFieldnames{ii});
    if isnumeric(optionValue)
        optionValue = num2str(optionValue);
    elseif ischar(optionValue)
        % do nothing
    else
        optionValue = 'error: value type not supported';
    end
	optionItem.appendChild(docNode.createTextNode(optionValue));
    optionsElement.appendChild(optionItem);
end

xmlwrite([t_path 'options.xml'],docNode);

end

