using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.StudentArchivesDAL
{
    public class Insert : AbstractFactory.IFactory<StudentArchives>
    {
        public bool Parameter(StudentArchives _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[StudentArchives]
                                           ([UserID]
                                          ,[PovertyArchivesID]
                                          ,[SchoolName]
                                          ,[PolicyID]
                                          ,[EduLevels]
                                          ,[StudentStatus]
                                          ,[DropoutSchool]
                                          ,[OutpreschoolReason]
                                          ,[ReturnSchool]
                                          ,[Remark]
                                          ,[IsLHS]
                                          ,[IsProvinceStudy]
                                          ,[SchoolNature]
                                          ,[LHSWorkId])
                                        VALUES
                                           ({0}
                                           ,{1}
                                           ,'{2}'
                                           ,'{3}'
                                           ,'{4}'
                                           ,'{5}'
                                           ,'{6}'
                                           ,'{7}'
                                           ,'{8}'
                                           ,'{9}'
                                           ,'{10}'
                                           ,'{11}'
                                           ,'{12}'
                                           ,'{13}'
                                           )", _obj.UserID, _obj.PovertyArchivesID, _obj.SchoolName.Replace("'", "''"), _obj.PolicyID, _obj.EduLevels, _obj.StudentStatus, _obj.DropoutSchool, _obj.OutpreschoolReason, _obj.ReturnSchool, _obj.Remark.Replace("'", "''"), _obj.IsLHS, _obj.IsProvinceStudy, _obj.SchoolNature, _obj.LHSWorkId);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('StudentArchives')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
        }

        public List<StudentArchives> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<StudentArchives> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
