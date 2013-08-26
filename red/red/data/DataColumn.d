module red.data.DataColumn;

class DataColumn
{
	private string _name;
	@property public string name() {return _name;}
	@property protected void name(string value) {_name = value;}

	this()
	{
	}
}

