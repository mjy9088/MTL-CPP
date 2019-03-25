#ifndef __mtl_list_arraylist
#define __mtl_list_arraylist

#include "../list.hpp"

namespace MTL
{
	template<typename T>
	class ArrayList : public List<T>
	{
	public:
		ArrayList(int len);
	};
}

#endif
