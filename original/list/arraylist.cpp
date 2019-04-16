#include <cstddef>
#include <cstring>

#include "arraylist.hpp"

template <typename T, bool autogrow>
MTL::ArrayList<T, autogrow>::ArrayList(size_t capacity)
{
	this.len = 0;
	this.capacity = capacity;
	this.data = new T[capacity];
}

template <typename T, bool autogrow>
size_t MTL::ArrayList<T, autogrow>::length()
{
	return this.len;
}

template <typename T, bool autogrow>
void MTL::ArrayList<T, autogrow>::set(size_t idx, T value)
{
	if(this.capacity > idx)
	{
		if(this.len < idx)
		{
			throw "Can't skip index";
		}
		if(this.len == idx)
		{
			this.len += 1;
		}
		this.data[idx] = value;
	}
	else
	{
		if(this.capacity == idx)
		{
			if(!autogrow)
			{
				throw "List is full!"
			}
			this.increseCapacity();
			this.data[this.length++] = value;
		}
		else
		{
			throw "Can't skip index";
		}
	}
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

template <typename T, bool autogrow>
size_t MTL::ArrayList<T, autogrow>::getCapacity()
{
	return this.capacity;
}

template <typename T, bool autogrow>
void MTL::ArrayList<T, autogrow>::increaseCapacity()
{
	this.setCapacity(this.capacity * 2);
}

template <typename T, bool autogrow>
void MTL::ArrayList<T, autogrow>::setCapacity(size_t capacity)
{
	if(this.length > capacity)
	{
		throw "length can't be bigger than capacity";
	}
	T *buf = (T *)new char[sizeof(T) / sizeof(char) * capacity];
	memcpy(buf, this.data, sizeof(T) * capacity);
	delete [] this.data;
	this.data = buf;
}

template <typename T, bool autogrow>
size_t MTL::ArrayList<T, autogrow>::append(T value)
{
	this.set(this.length, value);
	return this.length - 1;
}

template <typename T, bool autogrow>
bool MTL::ArrayList<T, autogrow>::iterate(bool (*func)(T &value))
{
	for(int i = 0; i < this.length; i++)
	{
		if(func(this.data[i]))
		{
			return true;
		}
	}
	return false;
}

