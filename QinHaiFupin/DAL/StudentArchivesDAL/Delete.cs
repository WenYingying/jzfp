using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.StudentArchivesDAL
{
    public class Delete : AbstractFactory.IFactory<StudentArchives>
    {
        public bool Parameter(StudentArchives _obj)
        {
            string sqltext = string.Format("DELETE FROM StudentArchives WHERE PovertyArchivesID={0}", long.Parse(_obj.PovertyArchivesID.ToString().Replace("'", "''")));
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<StudentArchives> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<StudentArchives> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
