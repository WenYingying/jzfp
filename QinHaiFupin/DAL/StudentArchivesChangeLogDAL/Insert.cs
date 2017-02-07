using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.StudentArchivesChangeLogDAL
{
    public class Insert : AbstractFactory.IFactory<StudentArchivesChangeLog>
    {
        public bool Parameter(StudentArchivesChangeLog _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[StudentArchivesChangeLog]
                                           ([StudentArchivesId]
                                          ,[UserId]
                                          ,[ChangeText])
                                        VALUES
                                           ({0}
                                           ,{1}
                                           ,'{2}')", _obj.StudentArchivesId, _obj.UserId, _obj.ChangeText.Replace("'", "''"));

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('StudentArchivesChangeLog')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
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
