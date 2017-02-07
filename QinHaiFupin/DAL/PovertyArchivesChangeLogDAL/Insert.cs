using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PovertyArchivesChangeLogDAL
{
    public class Insert : AbstractFactory.IFactory<PovertyArchivesChangeLog>
    {
        public bool Parameter(PovertyArchivesChangeLog _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[PovertyArchivesChangeLog]
                                           ([PovertyArchivesId]
                                          ,[UserId]
                                          ,[ChangeText])
                                        VALUES
                                           ({0}
                                           ,{1}
                                           ,'{2}')", _obj.PovertyArchivesId, _obj.UserId, _obj.ChangeText.Replace("'", "''"));

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('PovertyArchivesChangeLog')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
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
