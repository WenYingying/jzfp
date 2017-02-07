using System;
using AbstractFactory;
using System.Reflection;

namespace BLL
{
	public class BLL<T>
	{
		public static IFactory<T> Creator(string className)
		{
			return (IFactory<T>)Assembly.Load("DAL").CreateInstance(string.Format("DAL.{0}DAL.{1}",typeof(T).Name, className), true);
		}
	}
}
