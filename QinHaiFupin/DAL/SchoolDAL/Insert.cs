using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.SchoolDAL
{
    public class Insert : AbstractFactory.IFactory<Model.School>
    {
        public bool Parameter(School _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[School]
                                           ([Name]
                                          ,[Detail]
                                          ,[SchoolNature]
                                          ,[EduLevels]
                                          ,[ProvinceId]
                                          ,[CityId]
                                          ,[CountyId]
                                          ,[CountrysideId]
                                          ,[VillageId]
                                          ,[Address]
                                          ,[ClassSize]
                                          ,[StuEnrollment]
                                          ,[TchEnrollment]
                                          ,[SetupTime]
                                          ,[UserId]
                                          ,[LastModifyTime]
                                          ,[LastModifyUserId])
                                        VALUES
                                           ('{0}'
                                           ,'{1}'
                                           ,'{2}'
                                           ,'{3}'
                                           ,{4}
                                           ,{5}
                                           ,{6}
                                           ,{7}
                                           ,{8}
                                           ,'{9}'
                                           ,{10}
                                           ,{11}
                                           ,{12}
                                           ,'{13}'
                                           ,{14}
                                           ,'{15}'
                                           ,{16})", _obj.Name, _obj.Detail.Replace("'","''"), _obj.SchoolNature, _obj.EduLevels, _obj.ProvinceId, _obj.CityId, _obj.CountyId, _obj.CountrysideId, _obj.VillageId, _obj.Address, _obj.ClassSize, _obj.StuEnrollment, _obj.TchEnrollment, _obj.SetupTime, _obj.UserId, _obj.LastModifyTime, _obj.LastModifyUserId);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('School')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
        }

        public List<School> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<School> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
