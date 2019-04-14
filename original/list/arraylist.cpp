#include <cstddef>

#include "arraylist.hpp"

template <typename T, bool autogrow>
MTL::ArrayList<T, autogrow>::ArrayList(size_t len)
{
	this.len = len;
	this.data = new T[len];
}

template <typename T, bool autogrow>
size_t MTL::ArrayList<T, autogrow>::length()
{
	return this.len;
}

template <typename T, bool autogrow>
void MTL::ArrayList<T, autogrow>::set(size_t idx, T value)
{
	if(this.len > idx)
	{
		this.data[idx] = value;
	}
	else throw "Error";
}

template <typename T, bool autogrow>
T MTL::ArrayList<T, autogrow>::get(size_t idx)
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

