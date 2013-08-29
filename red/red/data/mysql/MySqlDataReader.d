module red.data.mysql.MySqlDataReader;

import red.data.Client;

class MySqlDataReader : IDataReader
{
	@property public size_t recordsAffected();
	@property public size_t fieldCount();
	
	@property public bool hasRows();
	
	public void read();
	public bool nextResult();
	
	public string opIndex(int ix);
	public string opIndex(string columnName);
}

