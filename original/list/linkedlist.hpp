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
		int len;
		LinkedList<T>::Node *head;
	public:
		LinkedList();
		~LinkedList();
		int length();
		void set(int idx, T value);
		virtual T get(int idx);
	};
}

#endif
