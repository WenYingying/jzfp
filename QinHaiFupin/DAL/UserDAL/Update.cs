using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.UserDAL
{
    public class Update : AbstractFactory.IFactory<Model.User>
    {
        public bool Parameter(User _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[User] SET
                                              [Phone]='{0}'
                                              ,[Name]='{1}'
                                               WHERE ID={2}", _obj.Phone, _obj.Name.Replace("'", "''"), _obj.ID);
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<User> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<User> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
