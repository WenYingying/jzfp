using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Reflection;
using System.Data.SqlClient;

namespace DAL.NoticeDAL
{
    public class Select : AbstractFactory.IFactory<Model.Notice>
    {
        public bool Parameter(Notice _obj)
        {
            throw new NotImplementedException();
        }

        public List<Notice> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM View_NoticeByRegion WHERE 1=1 {1}", select_list, select_search);
            List<Notice> list = new List<Notice>();
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                Type t = typeof(Notice);
                while (dr.Read())
                {
                    Notice _obj = new Notice();
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

        public List<Notice> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
