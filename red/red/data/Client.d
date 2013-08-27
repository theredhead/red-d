module red.data.Client;

enum ConnectionState
{
	OPENING,
	OPEN,
	CLOSING,
	CLOSED
}

interface IDbClient
{
	@property public  ConnectionState state();
	public void connect(string connectionString);
	public IDataReader execute(string statement);
	public IDataReader execute(string statement, string[] parameters, string[] arguments);

	public void open();
	public void close();
}

class DbConnection(T : IDbClient)
{
	private T _client;
	@property protected T client() {return _client;}
}

interface IDataReader
{
	@property public size_t recordsAffected();
	@property public size_t fieldCount();

	@property public bool hasRows();

	public void read();
	public bool nextResult();

	public string opIndex(int ix);
	public string opIndex(string columnName);


}
