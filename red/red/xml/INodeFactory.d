module red.xml.IDocumentTypeImplementation;

import red.xml.Element;

interface INodeFactory
{
	public Element createElement(string elementName);
}

