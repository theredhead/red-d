module red.web.Url;

import std.string;
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
		long ix;
		string work = urlString.dup;
		string queryString = "";

		// take from the front ...
		if (0 < (ix = work.indexOf("://")))
		{
			scheme = work[0 .. ix];
			work = work[ix + 3 .. $];
		}
		if (0 < (ix = work.indexOf("/")))
		{
			authority = work[0 .. ix];
			work = work[ix .. $];
		}
			
		// take from the back
		if (0 < (ix = work.indexOf("#")))
		{
			fragment = work[ix + 1.. $];
			work = work[0 .. ix];
		}
		if (0 < (ix = work.indexOf("?")))
		{
			query = parseQuery(work[ix .. $]);
			work = work[0 .. ix];
		}

		path = work.split("/");
	}

	public string[string] parseQuery(string queryString)
	{
		string[string] result;

		foreach (string bit; queryString.split("&"))
		{
			string key = bit[0 .. bit.indexOf("=")];
			string value = bit[ key.length + 1 .. $];

			result[key] = value;
		}

		return result;
	}

	@property string queryString()
	{
		string[] bits;
		foreach (k, v; query)
		{
			bits ~= [k ~ "=" ~ v];
		}
		return bits.join("&");
	}

	override public string toString()
	{
		string result = "";
		if (scheme != "")
		{
			result = scheme ~ "://";
		}
		result ~= authority;
		result ~= path.join("/");
		if (query.length > 0)
		{
			result ~= "?" ~ queryString;
		}
		if (fragment.length > 0)
		{
			result ~= "#" ~ fragment;
		}

		return result;
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

