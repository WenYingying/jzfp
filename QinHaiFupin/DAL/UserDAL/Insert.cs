using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.UserDAL
{
    public class Insert : AbstractFactory.IFactory<Model.User>
    {
        public bool Parameter(User _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[User]
                                           ([LoginName]
                                          ,[Password]
                                          ,[Name]
                                          ,[ProvinceId]
                                          ,[CityId]
                                          ,[CountyId]
                                          ,[CountrySideId]
                                          ,[VillageId]
                                          ,[InputBeginTime]
                                          ,[InputEndTime]
                                          ,[Lng]
                                          ,[Lat])
                                        VALUES
                                           ('{0}'
                                           ,'{1}'
                                           ,'{2}'
                                           ,{3}
                                           ,{4}
                                           ,{5}
                                           ,{6}
                                           ,{7}
                                           ,'{8}'
                                           ,'{9}'
                                           ,'{10}'
                                           ,'{11}')", _obj.LoginName.Replace("'", "''"), _obj.Password, _obj.Name.Replace("'", "''"), _obj.ProvinceId, _obj.CityId, _obj.CountyId, _obj.CountrySideId, _obj.VillageId,_obj.InputBeginTime, _obj.InputEndTime, _obj.Lng, _obj.Lat);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('User')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
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
