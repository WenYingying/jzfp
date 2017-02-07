using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.StudentArchivesDAL
{
	public class Select:IFactory<StudentArchives>
	{
		#region IFactory<StudentArchives> 成员

		public bool Parameter(StudentArchives _StudentArchives)
		{
			throw new NotImplementedException();
		}

		public List<StudentArchives> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM StudentArchives WHERE 1=1 {1}", select_list, select_search);
			List<StudentArchives> list = new List<StudentArchives>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(StudentArchives);
				while (dr.Read())
				{
					StudentArchives _obj = new StudentArchives();
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

		public List<StudentArchives> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}