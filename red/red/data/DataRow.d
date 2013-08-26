module red.data.DataRow;

import red.data.DataTable;
import red.data.DataColumn;

import std.algorithm;

class DataRow
{
	private string[] _data;
	
	private DataTable _table;
	@property public DataTable table() {return _table;}
	@property protected void table(DataTable value) {_table=value;}

	@property public DataColumn[] columns() {return table.columns();}

	this()
	{
	}

	this(DataTable ownerTable)
	{
		this();
		table = ownerTable;
	}

	public string opIndex(size_t ix)
	{
		return _data[ix];
	}

	public string opIndex(DataColumn col)
	{
		return _data[table.columns.countUntil(col)];
	}
}

