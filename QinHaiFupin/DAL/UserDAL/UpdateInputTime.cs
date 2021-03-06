﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.UserDAL
{
    public class UpdateInputTime : AbstractFactory.IFactory<Model.User>
    {
        public bool Parameter(User _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[User] SET
                                               [InputBeginTime]='{0}'
                                              ,[InputEndTime]='{1}'", _obj.InputBeginTime, _obj.InputEndTime);
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
