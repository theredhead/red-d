module red.xml.Element;

import red.xml.Node;
import red.xml.Document;
import red.xml.Attribute;

import std.string;

class Element : Node
{
	@property public string tagName() 
	{
		return _namespacePrefix != "" 
			? namespacePrefix ~ ":" ~ localName : localName;
	}
	@property public void tagName(string tagName)
	{
		localName = "";
		namespacePrefix = "";

		if (-1 < tagName.indexOf(":"))
		{
			localName = tagName;
		}
		else
		{
			namespacePrefix = tagName[0 .. tagName.indexOf(":")];
			localName = tagName[tagName.indexOf(":") + 1 .. $];
		}
	}

	private string _localName;
	@property public string localName() {return _localName;}
	@property protected void localName(string value) {_localName = value;}

	private string _namespacePrefix;
	@property public string namespacePrefix() {return _namespacePrefix;}
	@property protected void namespacePrefix(string value) {_namespacePrefix = value;}

	private Attribute[] _attributes;
	@property public Attribute[] attributes() {return _attributes;}
	@property protected void attributes(Attribute[] value) {_attributes = value;}


	@property override public string nodeValue()
	{
		return "";
	}

	public this(Document ownerDocument)
	{
		super(ownerDocument);
	}
}

