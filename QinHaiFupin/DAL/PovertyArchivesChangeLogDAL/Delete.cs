using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PovertyArchivesChangeLogDAL
{
    public class Delete : AbstractFactory.IFactory<Model.PovertyArchivesChangeLog>
    {
        public bool Parameter(PovertyArchivesChangeLog _obj)
        {
            string sqltext = string.Format("DELETE FROM PovertyArchivesChangeLog WHERE PovertyArchivesId={0}", long.Parse(_obj.PovertyArchivesId.ToString().Replace("'", "''")));
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<PovertyArchivesChangeLog> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<PovertyArchivesChangeLog> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
