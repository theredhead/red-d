module red.data.mysql.MySqlClient;

import red.data.Client;

class MySqlConnection : DbConnection
{
	override public string escape(string dirtyString)
	{
		return dirtyString;
	}
	override public string quote(string unquoted)
	{
		return "'"~unquoted~"'";
	}
	
	public void open()
	{
		state = ConnectionState.OPENING;
		// ...
		state = ConnectionState.OPEN;
	}
	public void close()
	{
		state = ConnectionState.CLOSING;
		// ...
		state = ConnectionState.CLOSED;
	}
}