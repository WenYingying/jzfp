using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.CountyDAL
{
	public class Select:IFactory<County>
	{
		#region IFactory<County> 成员

		public bool Parameter(County _County)
		{
			throw new NotImplementedException();
		}

		public List<County> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM County WHERE 1=1 {1}", select_list, select_search);
			List<County> list = new List<County>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(County);
				while (dr.Read())
				{
					County _obj = new County();
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

		public List<County> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}