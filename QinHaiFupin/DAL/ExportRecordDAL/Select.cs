using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.ExportRecordDAL
{
    public class Select : AbstractFactory.IFactory<Model.ExportRecord>
    {
        public bool Parameter(ExportRecord _obj)
        {
            throw new NotImplementedException();
        }

        public List<ExportRecord> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM ExportRecord WHERE 1=1 {1}", select_list, select_search);
            List<ExportRecord> list = new List<ExportRecord>();
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                Type t = typeof(ExportRecord);
                while (dr.Read())
                {
                    ExportRecord _obj = new ExportRecord();
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

        public List<ExportRecord> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
