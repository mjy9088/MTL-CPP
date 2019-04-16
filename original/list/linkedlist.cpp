#include <cstddef>

#include "linkedlist.hpp"

template <typename T>
class MTL::LinkedList<T>::Node
{
	MTL::LinkedList<T>::Node *next;
	T value;
};

template <typename T>
MTL::LinkedList<T>::LinkedList()
{
	this.len = 0;
	this.head = NULL;
	this.tail = NULL;
}

template <typename T>
size_t MTL::LinkedList<T>::length()
{
	return this.len;
}

template <typename T>
void MTL::LinkedList<T>::set(size_t idx, T value)
{
	if(idx < this.length)
	{
		MTL::LinkedList<T>::Node *tmp = this.head;
		for(size_t i = 0; i < idx; i++)
		{
			tmp = tmp->next;
		}
		tmp->value = value;
	}
	else
	{
		throw "Error";
	}
}

template <typename T>
T MTL::LinkedList<T>::get(size_t idx)
{
	if(idx < this.length)
	{
		MTL::LinkedList<T>::Node tmp = this.head;
		for(size_t i = 1; i < idx; i++)
		{
			tmp = tmp->next;
		}
		return tmp->value;
	}
	throw "Error";
}

template <typename T>
MTL::LinkedList<T>::~LinkedList()
{
	MTL::LinkedList<T>::Node *tmp = this.head, *temp;
	while(tmp->next)
	{
		temp = tmp;
		delete tmp;
		tmp = temp->next;
	}
	delete tmp;
}

template <typename T>
size_t MTL::LinkedList<T>::append(T value)
{
	MTL::LinkedList<T>::Node *tmp = new MTL::LinkedList<T>::Node();
	tmp->next = NULL;
	tmp->value = value;
	if(!this.tail)
	{
		this.tail = this.head = tmp;
	}
	else
	{
		this.tail = this.tail->next = tmp;
	}
	return this.length++;
}

template <typename T>
bool MTL::LinkedList<T>::iterate(bool (*func)(T &value))
{
	for(MTL::LinkedList<T>::Node *tmp = this.head; tmp; tmp = tmp->next)
	{
		if(func(tmp->value))
		{
			return true;
		}
	}
	return false;
}

template <typename T>
void MTL::LinkedList<T>::prepend(T value)
{
	MTL::LinkedList<T>::Node *tmp = new MTL::LinkedList<T>::Node();
	tmp->next = this.head;
	tmp->value = value;
	if(!this.head)
	{
		this.head = this.tail = tmp;
	}
	else
	{
		tmp->next = this.head;
		this.head = tmp->next;
	}
	return this.length++;
}

