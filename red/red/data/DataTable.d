module red.data.DataTable;

import red.data.DataColumn;
import red.data.DataRow;

class DataTable
{
	private DataColumn[] _columns;
	@property public DataColumn[] columns() {return _columns;}

	
	private DataRow[] _rows;
	@property public DataRow[] rows() {return _rows;}

	this()
	{
	}

	public DataRow opIndex(size_t ix)
	{
		return rows[ix];
	}
	
	public size_t opApply(size_t delegate(ref DataRow) dg) 
	{
		size_t result = 0;
		foreach(row; rows)
		{
			result = dg(row);
			if(result != 0) break;
		}
		return result;
	}

	public DataRow createRow()
	{
		DataRow result = new DataRow(this);

		return result;
	}
}

