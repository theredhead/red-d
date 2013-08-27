module red.data.mysql.MySqlClient;

import red.data.Client;

class MySqlClient : IDbClient
{
	this()
	{
	}

	// IDbClient 

	@property public ConnectionState state();
	public void connect(string connectionString);
	public IDataReader execute(string statement);
	public IDataReader execute(string statement, string[] parameters, string[] arguments);
	
	public void open();
	public void close();
}

class MySqlDataReader
{

}