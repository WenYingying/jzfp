using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.StudentArchivesPolicyDAL
{
    public class Select : AbstractFactory.IFactory<Model.StudentArchivesPolicy>
    {
        public bool Parameter(StudentArchivesPolicy _obj)
        {
            throw new NotImplementedException();
        }

        public List<StudentArchivesPolicy> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM View_StudentArchivesPolicy WHERE 1=1 {1}", select_list, select_search);
            List<StudentArchivesPolicy> list = new List<StudentArchivesPolicy>();
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                Type t = typeof(StudentArchivesPolicy);
                while (dr.Read())
                {
                    StudentArchivesPolicy _obj = new StudentArchivesPolicy();
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

        public List<StudentArchivesPolicy> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
