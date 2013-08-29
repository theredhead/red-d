module red.xml.Node;

import red.xml.Document;

abstract class Node
{
	private Document _ownerDocument;
	@property public Document ownerDocument() {return _ownerDocument;}
	@property protected void ownerDocument(Document value) {_ownerDocument = value;}
	
	private Node _parentNode;
	@property public Node parentNode() {return _parentNode;}
	@property protected void parentNode(Node value) {_parentNode = value;}

	@property abstract public string nodeValue();

	this()
	{
	}

	this(Document ownerDocument)
	{
		this();
		_ownerDocument = ownerDocument;
	}

	
}

