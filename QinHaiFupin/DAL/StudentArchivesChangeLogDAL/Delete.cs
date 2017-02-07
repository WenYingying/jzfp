using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.StudentArchivesChangeLogDAL
{
    public class Delete : AbstractFactory.IFactory<StudentArchivesChangeLog>
    {
        public bool Parameter(StudentArchivesChangeLog _obj)
        {
            string sqltext = string.Format("DELETE FROM StudentArchivesChangeLog WHERE StudentArchivesId={0}", long.Parse(_obj.StudentArchivesId.ToString().Replace("'", "''")));
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<StudentArchivesChangeLog> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<StudentArchivesChangeLog> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
