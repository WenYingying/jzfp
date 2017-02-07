using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PovertyArchivesDAL
{
    public class UpdateFromExcel : AbstractFactory.IFactory<Model.PovertyArchives>
    {
        public bool Parameter(PovertyArchives _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[PovertyArchives] SET
                                          [HouseStates]='{0}'
                                          ,[HouseholderId]={1}
                                          ,[StudentStatus]='{2}'
                                          ,[PovertyProperties]='{3}'
                                          ,[PovertyReason]='{4}'
                                          ,[Phone]='{5}'
                                          ,[IsHouseHolder]='{7}'
                                          ,[Nation]='{8}'
                                          ,[FamilySize]='{9}'
                                            WHERE ID={6}", _obj.HouseStates, _obj.HouseholderId,_obj.StudentStatus, _obj.PovertyProperties, _obj.PovertyReason, _obj.Phone, _obj.ID, _obj.IsHouseHolder,_obj.Nation,_obj.FamilySize);
            return DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0;
        }

        public List<PovertyArchives> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<PovertyArchives> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
