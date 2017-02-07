using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.CountrysideDAL
{
	public class Select:IFactory<Countryside>
	{
		#region IFactory<Countryside> 成员

		public bool Parameter(Countryside _Countryside)
		{
			throw new NotImplementedException();
		}

		public List<Countryside> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM Countryside WHERE 1=1 {1}", select_list, select_search);
			List<Countryside> list = new List<Countryside>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(Countryside);
				while (dr.Read())
				{
					Countryside _obj = new Countryside();
					for (int i = 0; i < dr.FieldCount; i++)
					{
						if (object.Equals(DBNull.Value, dr[i]))
							continue;
						PropertyInfo pi = t.GetProperty(dr.GetName(i));
						pi.SetValue(_obj, Convert.ChangeType(dr[i], pi.PropertyType), null);
					}

					list.Add(_obj);
				}
			}

			return list;
		}

		public List<Countryside> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}