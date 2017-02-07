using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PolicyDAL
{
    public class Delete : AbstractFactory.IFactory<Model.Policy>
    {
        public bool Parameter(Policy _obj)
        {
            string sqltext = string.Format("DELETE FROM Policy WHERE ID={0}", long.Parse(_obj.ID.ToString().Replace("'", "''")));
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<Policy> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<Policy> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
