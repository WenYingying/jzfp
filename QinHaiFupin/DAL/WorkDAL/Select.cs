using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace DAL.WorkDAL
{
    public class Select : AbstractFactory.IFactory<Model.Work>
    {
        public bool Parameter(Model.Work _obj)
        {
            throw new NotImplementedException();
        }

        public List<Model.Work> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM Work WHERE 1=1 {1}", select_list, select_search);
            List<Model.Work> list = new List<Model.Work>();
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                Type t = typeof(Model.Work);
                while (dr.Read())
                {
                    Model.Work _obj = new Model.Work();
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

        public List<Model.Work> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
