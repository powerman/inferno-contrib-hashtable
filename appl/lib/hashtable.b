# This module is actually 'Hash' module by:
# ehg@research.bell-labs.com 14Dec1996
# with polymorphism added to support any values.
implement HashTable;

include "../../module/hashtable.m";

# from Aho Hopcroft Ullman
fun1(s:string, n:int):int
{
	h := 0;
	m := len s;
	for(i:=0; i<m; i++){
		h = 65599*h+s[i];
	}
	return (h & 16r7fffffff) % n;
}

# from Limbo compiler
fun2(s:string, n:int):int
{
	h := 0;
	m := len s;
	for(i := 0; i < m; i++){
		c := s[i];
		d := c;
		c ^= c << 6;
		h += (c << 11) ^ (c >> 1);
		h ^= (d << 14) + (d << 7) + (d << 4) + d;
	}
	return (h & 16r7fffffff) % n;
}

Hash[T].new(size: int):ref Hash[T]
{
	return ref Hash[T](array[size] of list of ref HashNode[T]);
}

Hash[T].get(h: self ref Hash[T], key: string): T
{
	j := fun1(key,len h.a);
	for(q := h.a[j]; q!=nil; q = tl q){
		if((hd q).key==key)
			return (hd q).val;
	}
	return nil;
}

Hash[T].set(h: self ref Hash[T], key: string, val: T)
{
	j := fun1(key,len h.a);
	for(q := h.a[j]; q!=nil; q = tl q){
		if((hd q).key==key){
			(hd q).val = val;
			return;
		}
	}
	h.a[j] = ref HashNode[T](key,val) :: h.a[j];
}

Hash[T].del(h:self ref Hash, key:string)
{
	j := fun1(key,len h.a);
	dl:list of ref HashNode[T]; dl = nil;
	for(q := h.a[j]; q!=nil; q = tl q){
		if((hd q).key!=key)
			dl = (hd q) :: dl;
	}
	h.a[j] = dl;
}

Hash[T].all(h:self ref Hash): list of ref HashNode
{
	dl:list of ref HashNode[T]; dl = nil;
	for(j:=0; j<len h.a; j++)
		for(q:=h.a[j]; q!=nil; q = tl q)
			dl = (hd q) :: dl;
	return dl;
}
