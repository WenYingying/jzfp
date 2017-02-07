using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.NoticeDAL
{
    public class Delete : AbstractFactory.IFactory<Model.Notice>
    {
        public bool Parameter(Notice _obj)
        {
            string sqltext = string.Format("DELETE FROM Notice WHERE ID={0}", long.Parse(_obj.ID.ToString().Replace("'", "''")));
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<Notice> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<Notice> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
