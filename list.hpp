#ifndef __mtl_list
#define __mtl_list

#include "common.hpp"

namespace MTL
{
	class List
	{
	public:
		virtual int length();
		virtual bool set(int idx, void *value);
		virtual bool get(int idx, void **value);
	};
}

#endif
