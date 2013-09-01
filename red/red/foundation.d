module red.foundation;

import std.string;

template readUntil(T) if (isSomeString(T)) {

	T readUntil(ref T haystack, T needle)
	{
		// readuntil("Hello, World!", ", ")
		// haystack := "World!"
		// result   := "Hello"
	}

	T readUntil(ref T haystack, T[] needle)
	{
		
	}

}
