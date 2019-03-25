#ifndef __mtl_list_arraylist
#define __mtl_list_arraylist

#include "../list.hpp"

namespace MTL
{
	template<typename T>
	class ArrayList : public List<T>
	{
	private:
		int len;
		T *data;
	public:
		ArrayList(int len);
		~ArrayList();
		int length();
		void set(int idx, T value);
		virtual T get(int idx);
	};
}

#endif
