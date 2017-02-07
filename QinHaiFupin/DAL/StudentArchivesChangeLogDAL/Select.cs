using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.StudentArchivesChangeLogDAL
{
	public class Select:IFactory<StudentArchivesChangeLog>
	{
		#region IFactory<StudentArchivesChangeLog> 成员

		public bool Parameter(StudentArchivesChangeLog _StudentArchivesChangeLog)
		{
			throw new NotImplementedException();
		}

		public List<StudentArchivesChangeLog> Parameter(string select_list, string select_search)
		{
			string sqltext = string.Format("SELECT {0} FROM StudentArchivesChangeLog WHERE 1=1 {1}", select_list, select_search);
			List<StudentArchivesChangeLog> list = new List<StudentArchivesChangeLog>();
			using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
			{
				Type t = typeof(StudentArchivesChangeLog);
				while (dr.Read())
				{
					StudentArchivesChangeLog _obj = new StudentArchivesChangeLog();
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

		public List<StudentArchivesChangeLog> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
		{
			throw new NotImplementedException();
		}

		#endregion
	}
}