module red.data.DataRow;

import red.data.DataTable;
import red.data.DataColumn;

class DataRow
{
	private DataTable _table;
	@property public DataTable table() {return _table;}

	@property public DataColumn[] columns() {return table.columns();}

	this()
	{
	}
	this(DataTable ownerTable)
	{
		this();
		table = ownerTable;
	}

	public string opIndex(size_t atIndex)
	{

	}
}

