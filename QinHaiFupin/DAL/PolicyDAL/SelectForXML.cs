using Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace DAL.PolicyDAL
{
    public class SelectForXML : AbstractFactory.IFactory<Model.Policy>
    {
        #region IFactory<Policy> 成员

        public bool Parameter(Policy _Policy)
        {
            throw new NotImplementedException();
        }

        public List<Policy> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM Policy WHERE 1=1 {1}  FOR XML PATH('')", select_list, select_search);
            List<Policy> list = new List<Policy>();
            DataAccess.SqlAccess().ExecuteScalar(sqltext);
            using (SqlDataReader dr = DataAccess.SqlAccess().ExecuteReader(sqltext))
            {
                if (dr.Read())
                {
                    Policy _obj = new Policy();
                    _obj.Detail = dr[0].ToString();
                    list.Add(_obj);
                }
            }

            return list;
        }

        public List<Policy> Parameter(string select_list, string select_search, string select_order, int PageIndex, int PageSize, ref int PageCount, ref int TotalCnt)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}