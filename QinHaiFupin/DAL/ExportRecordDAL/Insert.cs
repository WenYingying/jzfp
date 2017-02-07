using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace DAL.ExportRecordDAL
{
    public class Insert : AbstractFactory.IFactory<Model.ExportRecord>
    {
        public bool Parameter(ExportRecord _obj)
        {
            string sqltext = string.Format(@"INSERT INTO [dbo].[ExportRecord]
                                              ( [UserId]
                                              ,[SortId]
                                              ,[HouseholderId]
                                              ,[FileName]
                                              ,[BatchNumber]
                                              ,[CityId]
                                              ,[CountyId]
                                              ,[CountrySideId]
                                              ,[VillageId])
                                        VALUES
                                           ({0}
                                           ,{1}
                                           ,{2}
                                           ,'{3}'
                                           ,'{4}'
                                           ,{5}
                                           ,{6}
                                           ,{7}
                                           ,{8})", _obj.UserId, _obj.SortId, _obj.HouseholderId,_obj.FileName.Replace("'", "''"), _obj.BatchNumber,_obj.CityId,_obj.CountyId,_obj.CountrySideId,_obj.VillageId);

            if (DataAccess.SqlAccess().ExecuteNonQuery(sqltext) > 0)
            {
                sqltext = "SELECT  IDENT_CURRENT('ExportRecord')";
                _obj.ID = Convert.ToInt64(DataAccess.SqlAccess().ExecuteScalar(sqltext));
            }
            return _obj.ID > 0;
        }

        public List<ExportRecord> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<ExportRecord> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            throw new NotImplementedException();
        }
    }
}
