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
	this.head = 0;
}

template <typename T>
size_t MTL::LinkedList<T>::length()
{
	return this.len;
}

template <typename T>
void MTL::LinkedList<T>::set(size_t idx, T value)
{
	if(idx > this.length)
	{
		throw "Error";
	}
	else if(idx < this.length)
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
		MTL::LinkedList<T>::Node tmp = this.head;
		for(size_t i = 1; i < idx; i++)
		{
			tmp = tmp->next;
		}
		tmp = tmp->next = new MTL::LinkedList<T>::Node();
		tmp->next = 0;
		tmp->value = value;
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

