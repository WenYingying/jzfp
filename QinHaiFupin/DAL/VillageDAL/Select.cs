using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.VillageDAL
{
	public class Select:IFactory<Village>
	{
		#region IFactory<Village> 成员

		public bool Parameter(Village _Village)
		{
			throw new NotImplementedException();
		}

		public List<Village> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM Village WHERE 1=1 {1}", select_list, select_search);
			List<Village> list = new List<Village>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(Village);
				while (dr.Read())
				{
					Village _obj = new Village();
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

		public List<Village> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}