module red.xml.Element;

import red.xml.Node;
import red.xml.Attribute;

class Element : Node
{
	@property public string tagName() 
	{
		return _namespacePrefix != "" 
			? namespacePrefix ~ ":" ~ localName : localName;
	}

	private string _localName;
	@property public string localName() {return _localName;}

	private string _namespacePrefix;
	@property public string namespacePrefix() {return _namespacePrefix;}
	
	private Attribute[] _attributes;
	@property public attributes() {return _attributes;}
	@property protected attributes(Attribute[] value) {_attributes = value;}
	
	this()
	{
		// Constructor code
	}
}

