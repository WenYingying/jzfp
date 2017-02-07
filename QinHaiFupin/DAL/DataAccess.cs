using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Configuration;

namespace DAL
{
    public class DataAccess
    {
        public static SQLHelpers SqlAccess()
        {
            SQLHelpers sql = (SQLHelpers)Assembly.Load("DAL").CreateInstance("DAL.SQLHelpers");
            sql.connStr = ConfigurationManager.AppSettings["SQLConnStr"].Trim();
            return sql;
        }

        public static SQLHelpers IpAccess()
        {
            SQLHelpers sql = (SQLHelpers)Assembly.Load("DAL").CreateInstance("DAL.SQLHelpers");
            sql.connStr = ConfigurationManager.AppSettings["IPConnStr"].Trim();
            return sql;
        }

        public static SQLHelpers ReadSqlAccess()
        {
            SQLHelpers sql = (SQLHelpers)Assembly.Load("DAL").CreateInstance("DAL.SQLHelpers");
            sql.connStr = ConfigurationManager.AppSettings["ReadSQLConnStr"].Trim();
            return sql;
        }

    }
}
