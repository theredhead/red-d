module red.web.Url;

/++
 + Defines host name types
 +/
enum HostNameType
{
	/++
	 + The host is set, but the type cannot be determined.
	 +/
	BASIC,

	/++
	 + Signifies that the hostname is a Domain Name System style address
	 +/
	DNS,

	/++
	 + Signifies that the hostname is an IPv4 address
	 +/
	IPV4,

	/**
	 * Signifies that the hostname is an IPv6 address
	 */
	IPV6,

	/**
	 * No hostname information is available (possible for relative urls)
	 */
	UNKNOWN
}

class Url
{

	private string _scheme;
	@property public string scheme() {return _scheme;}
	@property public void scheme(string value) {_scheme = value;}

	private string _authority;
	@property public string authority() {return _authority;}
	@property public void authority(string value) {_authority = value;}

	private string _hostname;
	@property public string hostname() {return _hostname;}
	@property public void hostname(string value) {_hostname = value;}

	private HostNameType _hostnameType;
	@property public HostNameType hostnameType() {return _hostnameType;}
	@property public void hostnameType(HostNameType value) {_hostnameType = value;}

	private string[] _path;
	@property public string[] path() {return _path;}
	@property public void path(string[] value) {_path = value;}

	private string[string] _query;
	@property public string[string] query() {return _query;}
	@property public void query(string[string] value) {_query = value;}

	private string _fragment;
	@property public string fragment() {return _fragment;}
	@property public void fragment(string value) {_fragment = value;}

	this()
	{
	}
	
	this(string urlString)
	{
		this();
		parse(urlString);
	}

	public void parse(string urlString)
	{

	}

	override public string toString()
	{
		return "todo";
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

