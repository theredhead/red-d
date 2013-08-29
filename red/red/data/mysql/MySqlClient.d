module red.data.mysql.MySqlClient;

import red.data.Client;

class MySqlClient : IDbClient
{
	this()
	{
	}

	// IDbClient 

	private ConnectionState _state;
	@property public ConnectionState state() {return _state;}
	@property protected void state(ConnectionState value) {_state = value;}
	public void connect(string connectionString) {}
	public IDataReader execute(string statement) {return null;}
	public IDataReader execute(string statement, string[] parameters, string[] arguments) {return null;}

	public string escape(string dirtyString)
	{
		return dirtyString;
	}
	public string quote(string unquoted)
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

class MySqlConnection : DbConnection!MySqlClient
{

}