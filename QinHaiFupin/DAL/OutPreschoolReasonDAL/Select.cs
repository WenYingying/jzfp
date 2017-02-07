using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;


namespace DAL.OutPreschoolReasonDAL
{
    public class Select : IFactory<OutPreschoolReason>
    {
        public bool Parameter(OutPreschoolReason _obj)
        {
            throw new NotImplementedException();
        }

        public List<OutPreschoolReason> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM OutPreschoolReason WHERE 1=1 {1}", select_list, select_search);
            List<OutPreschoolReason> list = new List<OutPreschoolReason>();
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                Type t = typeof(OutPreschoolReason);
                while (dr.Read())
                {
                    OutPreschoolReason _obj = new OutPreschoolReason();
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

        public List<OutPreschoolReason> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
