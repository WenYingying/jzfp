using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PovertyArchivesDAL
{
    public class UpdateAddressByHolder : AbstractFactory.IFactory<Model.PovertyArchives>
    {
        public bool Parameter(PovertyArchives _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[PovertyArchives] SET
                                          [Address]='{0}'
                                            WHERE HouseholderId={1}", _obj.Address.Replace("'", "''"), _obj.HouseholderId);
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
