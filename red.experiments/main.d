module main;

import std.stdio;
import red.data.common;
import red.data.Client;
import red.data.mysql.MySqlClient;

void main(string[] args)
{
	MySqlConnection connection;
	DbCommand command;

	connection = new MySqlConnection();
	
	command = connection.createCommand("SELECT * FROM people WHERE email=:email");
	command.parameters.addWithValue(":email", "kris@theredhead.nl");
	
	// Prints "Hello World" string in console
	writeln(command);
	
	// Lets the user press <Return> before program returns
	stdin.readln();
}

