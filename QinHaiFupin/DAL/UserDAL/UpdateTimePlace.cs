using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.UserDAL
{
    public class UpdateTimePlace : AbstractFactory.IFactory<Model.User>
    {
        public bool Parameter(User _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[User] SET
                                               [LastLoginTime]='{0}'
                                              ,[LastLoginIp]='{1}'
                                              ,[Lng]='{2}'
                                              ,[Lat]='{3}'
                                               WHERE ID={4}", _obj.LastLoginTime, _obj.LastLoginIp,_obj.Lng,_obj.Lat, _obj.ID);
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
