using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
namespace DAL.PovertyArchivesDAL
{
    public class Insert : AbstractFactory.IFactory<PovertyArchives>
    {
        public bool Parameter(PovertyArchives _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[PovertyArchives]
                                             ([Name]
                                              ,[Gender]
                                              ,[BirthDay]
                                              ,[IdCardNo]
                                              ,[Nation]
                                              ,[FamilySize]
                                              ,[VillageId]
                                              ,[HouseholderRelation]
                                              ,[EduLevels]
                                              ,[StudentStatus]
                                              ,[DiscerningStandards]
                                              ,[PovertyProperties]
                                              ,[PovertyReason]
                                              ,[Phone]
                                              ,[HouseholderId]
                                              ,[Address]
                                              ,[HouseStates]
                                              ,[State]
                                              ,[OffPovertyTime],[IsHouseHolder])
                                                VALUES
                                                   ('{0}'
                                                   ,'{1}'
                                                   ,'{2}'
                                                   ,'{3}'
                                                   ,'{4}'
                                                   ,{5}
                                                   ,{6}
                                                   ,'{7}'
                                                   ,'{8}'
                                                   ,'{9}'
                                                   ,'{10}'
                                                   ,'{11}'
                                                   ,'{12}'
                                                   ,'{13}'
                                                   ,{14}
                                                   ,'{15}'
                                                   ,'{16}'
                                                   ,'{17}'
                                                   ,'{18}','{19}')", _obj.Name, _obj.Gender, _obj.BirthDay, _obj.IdCardNo, _obj.Nation, _obj.FamilySize, _obj.VillageId, _obj.HouseholderRelation, _obj.EduLevels, _obj.StudentStatus, _obj.DiscerningStandards, _obj.PovertyProperties, _obj.PovertyReason, _obj.Phone, _obj.HouseholderId, _obj.Address, _obj.HouseStates, _obj.State, _obj.OffPovertyTime,_obj.IsHouseHolder);
            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('PovertyArchives')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
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
