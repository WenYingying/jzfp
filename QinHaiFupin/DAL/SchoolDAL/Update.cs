using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.SchoolDAL
{
    public class Update : AbstractFactory.IFactory<Model.School>
    {
        public bool Parameter(School _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[School] SET
                                              [Name]='{0}'
                                              ,[Detail]='{1}'
                                              ,[SchoolNature]='{2}'
                                              ,[EduLevels]='{3}'
                                              ,[ProvinceId]={4}
                                              ,[CityId]={5}
                                              ,[CountyId]={6}
                                              ,[CountrysideId]={7}
                                              ,[VillageId]={8}
                                              ,[Address]='{9}'
                                              ,[ClassSize]={10}
                                              ,[StuEnrollment]={11}
                                              ,[TchEnrollment]={12}
                                              ,[SetupTime]='{13}'
                                              ,[LastModifyTime]='{14}'
                                              ,[LastModifyUserId]={15}
                                               WHERE ID={16}", _obj.Name, _obj.Detail.Replace("'", "''"), _obj.SchoolNature, _obj.EduLevels, _obj.ProvinceId, _obj.CityId, _obj.CountyId, _obj.CountrysideId, _obj.VillageId, _obj.Address, _obj.SchoolNature, _obj.ClassSize, _obj.StuEnrollment, _obj.TchEnrollment, _obj.SetupTime, _obj.LastModifyTime, _obj.LastModifyUserId, _obj.ID);
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
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
