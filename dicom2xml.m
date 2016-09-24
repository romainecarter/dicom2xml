%Convert DICOM to XML
%Created: 8/30/2014
%Author:  Romaine A. Carter

function obj =  struct2xml(param)
    doc  = com.mathworks.xml.XMLUtils.createDocument(inputname(1));
    root = doc.getDocumentElement;
    
    obj  = xmlwrite(parse(param, doc, root));
end

function obj = parse(param, doc, root) 
    if isstruct(param)
        fields = fieldnames(param);
        for i  = 1 : numel(fields)
            if isstruct(param.(fields{i}))
                write(doc, root, fields{i}, '')
                parse(param.(fields{i}), doc, root.getLastChild)
            else
                write(doc, root, fields{i}, param.(fields{i}))
            end
        end
    else
       doc = 'could not convert'; 
    end
    
    obj = doc;
end

function write(doc, root, pname, param)
    if isempty(param) == 1
        root.appendChild(doc.createElement(pname));
    else
        elem = doc.createElement(pname);
        if ismatrix(param)
            val = mat2str(param);
        else
            val = num2str(param);
        end
        elem.appendChild(doc.createTextNode(val));
        root.appendChild(elem);
    end
end
