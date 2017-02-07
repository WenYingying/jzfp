using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.OutPreschoolReasonDAL
{
    class Insert : AbstractFactory.IFactory<Model.OutPreschoolReason>
    {
        public bool Parameter(OutPreschoolReason _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[OutPreschoolReason]
                                           ([Name]
                                            ,[Detail]
                                            ,[IsEnable])
                                        VALUES
                                           ('{0}'
                                           ,'{1}'
                                           ,'{2}')", _obj.Name.Replace("'", "''"), _obj.Detail.Replace("'", "''"), _obj.IsEnable);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('OutPreschoolReason')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
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
