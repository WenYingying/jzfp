using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Reflection;

namespace DAL.PovertyArchivesDAL
{
    public class Update : AbstractFactory.IFactory<PovertyArchives>
    {
        public bool Parameter(PovertyArchives _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[PovertyArchives] SET
                                           [Name]='{0}'
                                          ,[IdCardNo]='{1}'
                                          ,[Gender]='{2}'
                                          ,[BirthDay]='{3}'
                                          ,[Nation]='{4}'
                                          ,[HouseholderRelation]='{5}'
                                          ,[HouseholderId]={6}
                                            WHERE ID={7}", _obj.Name.Replace("'", "''"), _obj.IdCardNo, _obj.Gender, _obj.BirthDay, _obj.Nation, _obj.HouseholderRelation.Replace("'", "''"), _obj.HouseholderId, _obj.ID);
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<PovertyArchives> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<PovertyArchives> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
