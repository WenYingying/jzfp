using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.StudentArchivesDAL
{
    public class Update : AbstractFactory.IFactory<StudentArchives>
    {
        public bool Parameter(StudentArchives _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[StudentArchives] SET
                                                [SchoolName]='{0}'
                                                  ,[PolicyID]='{1}'
                                                  ,[EduLevel]='{2}'
                                                  ,[StudentStatus]='{3}'
                                                  ,[DropoutSchool]='{4}'
                                                  ,[OutpreschoolReason]='{5}'
                                                  ,[ReturnSchool]='{6}'
                                                  ,[Remark]='{7}'
                                                  ,[IsLHS]='{8}'
                                                  ,[IsProvinceStudy]='{9}'
                                                  ,[SchoolNature]='{10}'
                                                  ,[StudentNo]='{11}'
                                                  ,[LHSWorkId]={12}
                                               WHERE ID={13}", _obj.SchoolName.Replace("'", "''"), _obj.PolicyID, _obj.EduLevels, _obj.StudentStatus, _obj.DropoutSchool, _obj.OutpreschoolReason, _obj.ReturnSchool, _obj.Remark.Replace("'", "''"), _obj.IsLHS, _obj.IsProvinceStudy,_obj.SchoolNature, _obj.StudentNo, _obj.LHSWorkId, _obj.ID);
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
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
