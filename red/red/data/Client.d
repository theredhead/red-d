module red.data.Client;

import std.string;
import std.array;

/++
 + Used to indicate the current state of a database connection
 +/
enum ConnectionState
{
	OPENING,
	OPEN,
	CLOSING,
	CLOSED
}

/++
 + Represents the structure used to communicate queries with a database
 +/
public class DbCommand
{
	private DbConnection _connection;
	@property public DbConnection connection() {return _connection;}
	@property public void connection(DbConnection value) {_connection = value;}
	
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
			result = result.replace(p.name, connection.quote(connection.escape(p.value)));
		}
		return result;
	}
}

/++
 + Provides a skeleton for a database connection class
 +/
abstract class DbConnection
{
	private ConnectionState _state;
	@property public ConnectionState state() {return _state;}
	@property public void state(ConnectionState value) {_state = value;}

	abstract public string escape(string dirty);

	public string quote(string unquoted);

	public DbCommand createCommand()
	{
		return new DbCommand();
	}
	
	public DbCommand createCommand(string commandText)
	{
		DbCommand command = new DbCommand(this);
		command.commandText = commandText;
		return command;
	}
	
	public DbCommand createCommand(string commandText, string[] parameters, string[] arguments)
	{
		assert(parameters.length == arguments.length);
		DbCommand command = new DbCommand(this);
		for(int ix = 0; ix < parameters.length; ix++)
		{
			command.parameters.addWithValue(parameters[ix], arguments[ix]);
		}
		return command;
	}
}

/++
 + Represents a single parameter in a database command
 +/
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

/++
 + Represents a list of parameters in a database commands
 +/
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

/++
 + Defines the API for reading results from an executed database command
 +/
interface IDataReader
{
	@property public size_t recordsAffected();
	@property public size_t fieldCount();
	
	@property public bool hasRows();
	
	public void read();
	public bool nextResult();
	
	public string opIndex(int ix);
	public string opIndex(string columnName);
	/*
	public int getInt(int ix);
	public float getFloat(int ix);
	public string getString(int ix);
	*/
}

