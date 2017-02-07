using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.OutPreschoolReasonDAL
{
    public class Update : AbstractFactory.IFactory<Model.OutPreschoolReason>
    {
        public bool Parameter(OutPreschoolReason _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[OutPreschoolReason] SET
                                                      [Name]='{0}'
                                                     ,[Detail]='{1}'
                                               WHERE ID={2}", _obj.Name.Replace("'", "''"), _obj.Detail.Replace("'", "''"), _obj.ID);
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<OutPreschoolReason> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<OutPreschoolReason> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
