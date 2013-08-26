module red.xml.Attribute;

import red.xml.Node;

class Attribute : Node
{
	private string _name;
	@property public string name() {return _name;}
	@property public void name(string value) {_name = value;}

	private string _value;
	@property public string value() {return _value;}
	@property public void value(string value) {_value = value;}
	
	this(string name, string value)
	{
		_name = name;
		_value = value;
	}
}

