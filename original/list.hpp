#ifndef __mtl_list
#define __mtl_list

#include "common.hpp"

namespace MTL
{
	template<typename T>
	class List
	{
	public:
		virtual size_t length();
		virtual void set(int idx, T value);
		virtual T get(int idx);
	};
}

#endif
