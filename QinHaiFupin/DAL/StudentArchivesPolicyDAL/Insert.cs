using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.StudentArchivesPolicyDAL
{
    public class Insert : AbstractFactory.IFactory<Model.StudentArchivesPolicy>
    {
        public bool Parameter(StudentArchivesPolicy _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[StudentArchivesPolicy]
                                           ([StudentArchivesID]
                                           ,[PolicyID]
                                           ,[Amount])
                                        VALUES
                                           ({0}
                                           ,{1}
                                           ,'{2}')", _obj.StudentArchivesID, _obj.PolicyID, _obj.Amount);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('StudentArchivesPolicy')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
        }

        public List<StudentArchivesPolicy> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<StudentArchivesPolicy> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
