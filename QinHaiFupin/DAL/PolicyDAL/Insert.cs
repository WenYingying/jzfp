using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PolicyDAL
{
    public class Insert : AbstractFactory.IFactory<Model.Policy>
    {
        public bool Parameter(Policy _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[Policy]
                                           ([Name]
                                            ,[Detail]
                                            ,[EduLevels]
                                            ,[CityID]
                                            ,[CountyID]
                                            ,[ProvinceID]
                                            ,[IsEnable]
                                            ,[UserId]
                                            ,[Amount]
                                            ,[Grade])
                                        VALUES
                                           ('{0}'
                                           ,'{1}'
                                           ,'{2}'
                                           ,{3}
                                           ,{4}
                                           ,{5}
                                           ,'{6}'
                                           ,{7}
                                           ,'{8}'
                                           ,{9})", _obj.Name.Replace("'", "''"), _obj.Detail.Replace("'", "''"), _obj.EduLevels.Replace("'", "''"), _obj.CityID,_obj.CountyID,_obj.ProvinceID,_obj.IsEnable, _obj.UserId, _obj.Amount, _obj.Grade);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('Policy')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
        }

        public List<Policy> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<Policy> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
