#include "arraylist.hpp"

template <typename T>
MTL::ArrayList<T>::ArrayList(int len)
{
	this.len = len;
	this.data = new T[len];
}

template <typename T>
int MTL::ArrayList<T>::length()
{
	return this.len;
}

template <typename T>
void MTL::ArrayList<T>::set(int idx, T value)
{
	if(this.len > idx)
	{
		this.data[idx] = value;
	}
	else throw "Error";
}

