using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.PolicyDAL
{
	public class Select:IFactory<Policy>
	{
		#region IFactory<Policy> 成员

		public bool Parameter(Policy _Policy)
		{
			throw new NotImplementedException();
		}

		public List<Policy> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM Policy LEFT JOIN Province ON Policy.ProvinceID=Province.ID LEFT JOIN City ON Policy.CityID=City.ID  LEFT JOIN County ON Policy.CountyID=County.ID WHERE 1=1 {1}", select_list, select_search);
			List<Policy> list = new List<Policy>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(Policy);
				while (dr.Read())
				{
					Policy _obj = new Policy();
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

		public List<Policy> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}