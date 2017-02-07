using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.PovertyArchivesDAL
{
    public class UpdateEInformation : AbstractFactory.IFactory<Model.PovertyArchives>
    {
        public bool Parameter(PovertyArchives _obj)
        {
            string sqltext = string.Format(@"UPDATE [dbo].[PovertyArchives] SET
                                          [VillageId]={0}
                                          ,[FamilySize]={1}
                                          ,[DiscerningStandards]='{2}'
                                          ,[PovertyProperties]='{3}'
                                          ,[PovertyReason]='{4}'
                                          ,[Phone]='{5}'
                                          ,[Address]='{6}'
                                          ,[HouseholderId]={7}
                                            WHERE ID={8}", _obj.VillageId, _obj.FamilySize, _obj.DiscerningStandards.Replace("'", "''"), _obj.PovertyProperties.Replace("'", "''"), _obj.PovertyReason.Replace("'", "''"), _obj.Phone, _obj.Address.Replace("'", "''"), _obj.HouseholderId, _obj.ID);
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
