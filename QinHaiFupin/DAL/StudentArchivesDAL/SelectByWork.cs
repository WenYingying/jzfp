using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Data;

namespace DAL.StudentArchivesDAL
{
    public class SelectByWork : AbstractFactory.IFactory<Model.StudentArchives>
    {
        public bool Parameter(StudentArchives _obj)
        {
            throw new NotImplementedException();
        }

        public List<StudentArchives> Parameter(string select_list, string select_search)
        {
            string sqltext = string.Format("SELECT {0} FROM View_StudentArchivesWork WHERE 1=1 {1}", select_list, select_search);
            List<StudentArchives> list = new List<StudentArchives>();
            DataSet ds = DataAccess.SqlAccess().GetDataSet(sqltext);
            list.Add(new StudentArchives { ID = Convert.ToInt64(ds.Tables[0].Rows.Count) });
            ds.Dispose();
            return list;
        }

        public List<StudentArchives> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
