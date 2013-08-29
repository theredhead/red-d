module red.web.Url;

enum UrlMode
{
	RELATIVE,
	ABSOLUTE
}

class Url
{
	private UrlMode _mode = UrlMode.ABSOLUTE;
	@property public UrlMode mode() {return _mode;}
	@property public void mode(UrlMode value) {_mode = value;}
	
	private int _port;
	private string _protocol;
	private string _username;
	private string _password;
	private string _hostname;
	private string _path;
	private string[string] _query;
	private string _fragment;

	this()
	{
	}

	this(UrlMode mode)
	{
		this();
		_mode = mode;
	}

	this(string urlString, UrlMode mode = UrlMode.ABSOLUTE)
	{
		this(mode);
		parse(urlString);
	}

	public void parse(string urlString)
	{

	}

	override public string toString()
	{
		final switch(_mode)
		{
			case UrlMode.RELATIVE :
				return toRelativeUrlString();
				break;
			case UrlMode.ABSOLUTE :
				return toAbsoluteUrlString();
				break;
		}
	}

	protected string toRelativeUrlString()
	{
		return "...";
	}

	protected string toAbsoluteUrlString()
	{
		return "://...";
	}
}

