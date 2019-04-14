#ifndef __mtl_list_arraylist
#define __mtl_list_arraylist

#include "../list.hpp"

namespace MTL
{
	template<typename T, bool autogrow = true>
	class ArrayList : public List<T>
	{
	private:
		size_t len;
		T *data;
	public:
		ArrayList(size_t len);
		~ArrayList();
		size_t length();
		void set(size_t idx, T value);
		virtual T get(size_t idx);
	};
}

#endif
