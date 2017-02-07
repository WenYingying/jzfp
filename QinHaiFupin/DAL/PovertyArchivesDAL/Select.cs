using System;
using System.Collections.Generic;
using AbstractFactory;
using Model;
using System.Data.SqlClient;
using System.Reflection;

namespace DAL.PovertyArchivesDAL
{
    public class Select : IFactory<PovertyArchives>
    {
        public bool Parameter(PovertyArchives _obj)
        {
            throw new NotImplementedException();
        }

        public List<PovertyArchives> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM View_PovertyArchives WHERE 1=1 {1}", select_list, select_search);
            List<PovertyArchives> list = new List<PovertyArchives>();
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                Type t = typeof(PovertyArchives);
                while (dr.Read())
                {
                    PovertyArchives _obj = new PovertyArchives();
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

        public List<PovertyArchives> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
