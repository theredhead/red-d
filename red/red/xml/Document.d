module red.xml.Document;

import red.xml.INodeFactory;
import red.xml.Element;
import red.xml.Node;
import std.string;

class Document : Node, INodeFactory
{
	this()
	{
		// Constructor code
	}

	public Element createElement(string tagName)
	{
		Element e = new Element(this);
		e.tagName = tagName;
		return e;
	}
	@property override public string nodeValue()
	{
		return "";
	}

}

