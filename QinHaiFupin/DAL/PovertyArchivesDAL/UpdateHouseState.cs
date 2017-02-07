using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PovertyArchivesDAL
{
    public class UpdateHouseState : AbstractFactory.IFactory<Model.PovertyArchives>
    {
        public bool Parameter(PovertyArchives _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[PovertyArchives] SET
                                          [HouseStates]='{0}'
                                          ,[HouseholderId]={1}
                                          ,[EduLevels]='{2}'
                                          ,[StudentStatus]='{3}'
                                          ,[PovertyProperties]='{4}'
                                          ,[PovertyReason]='{5}'
                                          ,[Phone]='{6}'
                                            WHERE ID={7}", _obj.HouseStates, _obj.HouseholderId, _obj.EduLevels, _obj.StudentStatus, _obj.PovertyProperties, _obj.PovertyReason, _obj.Phone, _obj.ID);
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
