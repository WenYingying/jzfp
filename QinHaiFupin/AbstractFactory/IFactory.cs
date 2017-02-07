using System;
using System.Collections.Generic;

namespace AbstractFactory
{
	public interface IFactory<T>
	{
		/// <summary>
		/// 修改方法
		/// </summary>
		bool Parameter(T _obj);
		/// <summary>
		/// 查询方法
		/// </summary>
		List<T> Parameter(string select_list, string select_search);
		/// <summary>
		/// 分页方法
		/// </summary>
		List<T> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount);
	}
}
