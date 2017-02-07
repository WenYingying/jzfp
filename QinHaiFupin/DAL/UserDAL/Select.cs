using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.UserDAL
{
	public class Select:IFactory<User>
	{
		#region IFactory<User> 成员

		public bool Parameter(User _User)
		{
			throw new NotImplementedException();
		}

		public List<User> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM View_UserByRegion WHERE 1=1 {1}", select_list, select_search);
			List<User> list = new List<User>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(User);
				while (dr.Read())
				{
					User _obj = new User();
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

		public List<User> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}