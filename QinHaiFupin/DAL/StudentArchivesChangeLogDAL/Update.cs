﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.StudentArchivesChangeLogDAL
{
    public class Update : AbstractFactory.IFactory<StudentArchivesChangeLog>
    {
        public bool Parameter(StudentArchivesChangeLog _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[StudentArchivesChangeLog] SET
                                                      [ChangeText]='{0}'
                                               WHERE ID={1}", _obj.ChangeText.Replace("'", "''"), _obj.ID);
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
