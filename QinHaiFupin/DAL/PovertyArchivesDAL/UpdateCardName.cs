using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.PovertyArchivesDAL
{
   public class UpdateCardName : AbstractFactory.IFactory<Model. PovertyArchives>
    {
        public bool Parameter(Model.PovertyArchives _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[PovertyArchives] SET
                                          [IdCardNo]='{0}'
                                          ,[Name]='{1}'
                                            WHERE ID={2}", _obj.IdCardNo.Replace("'", "''"), _obj.Name.Replace("'", "''"), _obj.ID);
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<Model.PovertyArchives> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<Model.PovertyArchives> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
