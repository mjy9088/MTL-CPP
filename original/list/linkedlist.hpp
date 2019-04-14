#ifndef __mtl_list_linkedlist
#define __mtl_list_linkedlist

#include "../list.hpp"

namespace MTL
{
	template<typename T>
	class LinkedList : public List<T>
	{
	private:
		class Node;
		size_t len;
		LinkedList<T>::Node *head;
	public:
		LinkedList();
		~LinkedList();
		size_t length();
		void set(size_t idx, T value);
		virtual T get(size_t idx);
	};
}

#endif
