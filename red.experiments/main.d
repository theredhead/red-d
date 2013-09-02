module main;

import std.stdio;
import red.data.common;
import red.data.Client;
import red.data.mysql.MySqlClient;

import red.web.Url;
import std.string;

void main(string[] args)
{
	MySqlConnection connection;
	DbCommand command;

	connection = new MySqlConnection();
	
	command = connection.createCommand("SELECT * FROM people WHERE email=:email");
	command.parameters.addWithValue(":email", "kris@theredhead.nl");
	
	// Prints "Hello World" string in console
	writeln(command);

	string test = "http://kris:fietsbel@www.theredhead.nl/blog/archive/2013-01?ordered=chronologically#article-123";
	Url url = new Url(test);

	writeln("test:      ["~test~"]");
	writeln("scheme:    " ~ url.scheme);
	writeln("authority: " ~ url.authority);
	writeln("path:      " ~ url.path.join("/"));
	writeln("query:     " ~ url.queryString);
	writeln("fragment:  " ~ url.fragment);

	writeln("toString:  " ~ url.toString());




	// Lets the user press <Return> before program returns
	stdin.readln();
}

