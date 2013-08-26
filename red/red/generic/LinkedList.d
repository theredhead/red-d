module red.generic.LinkedList;

/**
 * Implements a very basic singularly linked list
 */
template LinkedList(T)
{
	public class LinkedList
	{
		protected Node current;
		protected Node head;

		private size_t _length = 0;
		public size_t length()
		{
			return _length;
		}
		
		/**
		 * Append an item to this list
		 */
		public void append(T value)
		{
			Node newNode = new Node(value);
			if (head is null)
			{
				head = newNode;
			}
			else
			{
				Node p = head;
				while(p.next !is null)
				{
					p = p.next;
				}
				p.next = newNode;
			}
			_length += 1;
		}
		
		/**
		 * prepend an item to this list
		 */
		public void prepend(T value)
		{
			Node newNode = new Node(value);
			if (head is null)
			{
				head = newNode;
			}
			else
			{
				Node oldHead = head;
				oldHead.previous = newNode;
				newNode.next = head;
				head = newNode;
			}
			_length += 1;
		}
		
		/**
		 * fetch item #atIndex from this list.
		 * Note that the list is not indexed and this performs a loop
		 */
		public T opIndex(size_t atIndex)
		{
			Node n = head;
			size_t i = 0;
			while (i < atIndex)
			{
				n = n.next;
				if (n is null)
				{
					return null;
				}
			}
			return n.value;
		}
		
		/**
		 * Empties this list
		 */
		public void clear()
		{
			head = null;
			_length = 0;
		}
		
		/**
		 * foreach support
		 */
		public size_t opApply( size_t delegate( ref T ) dg ) 
		{
			for( Node n = head; n; n = n.next ) 
			{
				if( auto r = dg( n.value ) ) 
					return r;
			}
			return 0;
		}
		
		private static class Node
		{
			public this()
			{
			}
			
			public this(T initialValue) 
			{
				this();
				value = initialValue;
			}
			
			public T value;
			public Node next;
		}
	}
}