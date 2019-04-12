#include "arraylist.hpp"

template <typename T, bool autogrow>
MTL::ArrayList<T, autogrow>::ArrayList(int len)
{
	this.len = len;
	this.data = new T[len];
}

template <typename T, bool autogrow>
int MTL::ArrayList<T, autogrow>::length()
{
	return this.len;
}

template <typename T, bool autogrow>
void MTL::ArrayList<T, autogrow>::set(int idx, T value)
{
	if(this.len > idx)
	{
		this.data[idx] = value;
	}
	else throw "Error";
}

template <typename T, bool autogrow>
T MTL::ArrayList<T, autogrow>::get(int idx)
{
	if(this.len > idx)
	{
		return this.data[idx];
	}
	else throw "Error";
}

template <typename T, bool autogrow>
MTL::ArrayList<T, autogrow>::~ArrayList()
{
	delete [] this.data;
}

