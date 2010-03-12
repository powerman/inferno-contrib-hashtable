HashTable: module
{
	PATH: con "hashtable.dis";
	fun1, fun2: fn(s:string,n:int):int;

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

