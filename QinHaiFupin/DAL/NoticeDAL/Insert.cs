using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.NoticeDAL
{
    public class Insert : AbstractFactory.IFactory<Model.Notice>
    {
        public bool Parameter(Notice _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[Notice]
                                           ([Name]
                                          ,[Detail]
                                          ,[ProvinceID]
                                          ,[CityID]
                                          ,[CountyID]
                                          ,[UserId])
                                        VALUES
                                           ('{0}'
                                           ,'{1}'
                                           ,{2}
                                           ,{3}
                                           ,{4}
                                           ,{5})", _obj.Name, _obj.Detail.Replace("'", "''"), _obj.ProvinceID, _obj.CityID, _obj.CountyID, _obj.UserId);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('Notice')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
        }

        public List<Notice> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<Notice> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
