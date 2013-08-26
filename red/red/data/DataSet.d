module red.data.DataSet;

import red.data.DataTable;

class DataSet
{
	private DataTable[] _tables;
	@property public DataTable[] tables() {return _tables;}
	@property protected void tables(DataTable[] value) {_tables = value;}

	this()
	{
	}
}

