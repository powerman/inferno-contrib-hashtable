HashTable: module
{
	PATH: con "/opt/powerman/hashtable/dis/lib/hashtable.dis";

	HashNode: adt[T]{
		key:string;
		val:T;
	};
	Hash: adt[T]{
		a:	array of list of ref HashNode[T];
		new:	fn(size:int):ref Hash[T];
		get:	fn(h:self ref Hash[T], key:string):T;
		set:	fn(h:self ref Hash[T], key:string, val:T);
		del:	fn(h:self ref Hash[T], key:string);
		all:	fn(h:self ref Hash[T]): list of ref HashNode[T];
	};
};

