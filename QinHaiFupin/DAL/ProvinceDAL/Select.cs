using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.ProvinceDAL
{
	public class Select:IFactory<Province>
	{
		#region IFactory<Province> 成员

		public bool Parameter(Province _Province)
		{
			throw new NotImplementedException();
		}

		public List<Province> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM Province WHERE 1=1 {1}", select_list, select_search);
			List<Province> list = new List<Province>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(Province);
				while (dr.Read())
				{
					Province _obj = new Province();
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

		public List<Province> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}