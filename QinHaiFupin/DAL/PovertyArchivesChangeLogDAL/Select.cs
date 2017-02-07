using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace DAL.PovertyArchivesChangeLogDAL
{
    public class Select : AbstractFactory.IFactory<Model.PovertyArchivesChangeLog>
    {
        #region IFactory<ProvertyArchivesChangeLog> 成员

        public bool Parameter(Model.PovertyArchivesChangeLog _PovertyArchivesChangeLog)
        {
            throw new NotImplementedException();
        }

        public List<Model.PovertyArchivesChangeLog> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM PovertyArchivesChangeLog WHERE 1=1 {1}", select_list, select_search);
            List<Model.PovertyArchivesChangeLog> list = new List<Model.PovertyArchivesChangeLog>();
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                Type t = typeof(Model.PovertyArchivesChangeLog);
                while (dr.Read())
                {
                    Model.PovertyArchivesChangeLog _obj = new Model.PovertyArchivesChangeLog();
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

        public List<Model.PovertyArchivesChangeLog> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}
