module red.data.Client;

import std.string;
import std.array;

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
	
	public string escape(string dirtyString);
	public string quote(string unquoted);

	public void open();
	public void close();
}

interface IDbCommand
{
	@property public IDbConnection connection();
	@property public void connection(IDbConnection value);

	@property public string commandText();
	@property public void commandText(string value);
	
	@property public DbCommandParameterList parameters();
	@property public void parameters(DbCommandParameterList value);
}

interface IDbConnection
{
	public string quote(string unquopted);
	public string escape(string dirty);

	public IDbCommand createCommand();
}

abstract class ADbConnection : IDbConnection
{
	abstract public IDbCommand createCommand();
	
	public IDbCommand createCommand(string commandText)
	{
		IDbCommand command = createCommand();
		command.commandText = commandText;
		return command;
	}

	public IDbCommand createCommand(string commandText, string[] parameters, string[] arguments)
	{
		IDbCommand command = createCommand(commandText);
		assert(parameters.length == arguments.length);
		for(int ix = 0; ix < parameters.length; ix++)
		{
			command.parameters.addWithValue(parameters[ix], arguments[ix]);
		}
		return command;
	}
}

class DbConnection(T : IDbClient) : ADbConnection
{
	private T _client;
	@property protected T client() {return _client;}

	public class DbCommand : IDbCommand
	{
		private IDbConnection _connection;
		@property public IDbConnection connection() {return _connection;}
		@property public void connection(IDbConnection value) {_connection = value;}
		
		private string _commandText;
		@property public string commandText() {return _commandText;}
		@property public void commandText(string value) {_commandText = value;}
		
		private DbCommandParameterList _parameters;
		@property public DbCommandParameterList parameters() {return _parameters;}
		@property protected void parameters(DbCommandParameterList value) {_parameters = value;}
		
		public this()
		{
			_parameters = new DbCommandParameterList();
		}
		
		public this(DbConnection connection)
		{
			this();
			_connection = connection;
		}
		
		public this(DbConnection connection, string commandText)
		{
			this(connection);
			_commandText = commandText;
		}
		
		public this(DbConnection connection, string commandText, string[string] parameters)
		{
			this(connection, commandText);
			foreach(v, k; parameters)
			{
				_parameters.addWithValue(k, v);
			}
		}
		
		override public string toString()
		{
			string result = commandText;
			foreach(DbCommandParameter p; parameters)
			{
				result.replace(p.name, escape(p.value));
			}
			return result;
		}
	}
	
	public string escape(string dirty)
	{
		return client.escape(dirty);
	}

	public string quote(string unquoted)
	{
		return client.quote(unquoted);
	}

	override public IDbCommand createCommand()
	{
		return new DbCommand();
	}
}

class DbCommandParameter
{
	public this(string name)
	{
		this.name = name;
	}

	private string _name;
	@property protected string name() {return _name;}
	@property public void name(string value) {_name = value;}

	private string _value;
	@property public string value() {return _value;}
	@property public void value(string value) {_value = value;}
}

static class DbNull
{
	@property static public string value()
	{
		return DbNull.mangleof;
	}
}

class DbCommandParameterList
{
	private DbCommandParameter[string] _list;

	public DbCommandParameter opIndex(string name)
	{
		return _list[name];
	}

	public void addWithValue(string name, string value)
	{
		if (_list.get(name, null) is null)
		{
			DbCommandParameter p = new DbCommandParameter(name);
			p.value = value;
			_list[name] = p;
		}
		else
		{
			// throw 
		}
	}

	int opApply(int delegate(ref DbCommandParameter) dg)
	{
		int result = 0;
		foreach(DbCommandParameter p; _list)
		{
			result = dg(p);
			if (result) break;
		}
		return result;
	}
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
