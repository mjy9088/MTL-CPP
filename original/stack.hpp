#ifndef __mtl_list
#define __mtl_list

#include "common.hpp"

namespace MTL
{
	template<typename T>
	class Stack
	{
	public:
		virtual size_t length();
		virtual size_t push(T value);
		virtual T pop();
		virtual T peek();
		virtual bool iterate(bool (*func)(T &value));
	};
}

#endif
