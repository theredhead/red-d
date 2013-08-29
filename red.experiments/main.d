module main;

import std.stdio;
import red.data.common;
import red.data.MySqlClient;

void main(string[] args)
{

	auto cn = new MySqlConnection();

	DbCommand command = cn.createCommand("SELECT * FROM people WHERE lastName=:lastName");
	command.parameters.addWithValue(":lastName", "Herlaar");

	// Prints "Hello World" string in console
	writeln(command);
	
	// Lets the user press <Return> before program returns
	stdin.readln();
}

