#ifndef __mtl_list_arraylist
#define __mtl_list_arraylist

#include "../list.hpp"

namespace MTL
{
	template<typename T, bool autogrow = true>
	class ArrayList : public List<T>
	{
	private:
		size_t len, capacity;
		T *data;
	public:
		ArrayList(size_t capacity);
		~ArrayList();
		size_t length();
		void set(size_t idx, T value);
		virtual T get(size_t idx);
		size_t getCapacity();
		void increaseCapacity();
		void setCapacity(size_t capacity);
		size_t append(T value);
		bool iterate(bool (*func)(T &value));
	};
}

#endif
