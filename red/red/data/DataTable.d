module red.data.DataTable;

import red.data.DataColumn;
import red.data.DataRow;

class DataTable
{
	private DataColumn[] _columns;
	@property public DataColumn[] columns() {return _columns;}


	private DataRowp[] _rows;
	@property public DataRow[] rows() {return _rows;}

	this()
	{
	}

	public T opIndex(size_t atIndex)
	{
	}
	
	public size_t opApply(size_t delegate(ref DataRow) dg) 
	{
	}

	public DataRow createRow()
	{
		DataRow result = new DataRow(this);

		return result;
	}
}

