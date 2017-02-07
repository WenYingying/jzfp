﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Data.SqlClient;
using System.Data;

namespace DAL.NoticeDAL
{
    public class Pager : AbstractFactory.IFactory<Model.Notice>
    {
        public bool Parameter(Notice _obj)
        {
            throw new NotImplementedException();
        }

        public List<Notice> Parameter(string select_list, string select_search)
        {
            throw new NotImplementedException();
        }

        public List<Notice> Parameter(string select_list, string select_search, string select_order, int pageno, int pagesize, ref int pagecount, ref int recordcount)
        {
            string sqltext = "Pager";
            List<SqlParameter> Params = new List<SqlParameter>();

            SqlParameter paraPageCount = new SqlParameter();
            paraPageCount.ParameterName = "@PageCount";
            paraPageCount.SqlDbType = SqlDbType.Int;
            paraPageCount.Direction = ParameterDirection.Output;
            Params.Add(paraPageCount);

            SqlParameter recordscnt = new SqlParameter();
            recordscnt.ParameterName = "@Cnt";
            recordscnt.SqlDbType = SqlDbType.Int;
            recordscnt.Direction = ParameterDirection.Output;
            Params.Add(recordscnt);

            Params.Add(new SqlParameter("@WhichTable", "View_NoticeByRegion"));
            Params.Add(new SqlParameter("@KeyCol", "ID"));
            Params.Add(new SqlParameter("@Col", select_list));
            Params.Add(new SqlParameter("@SearchStr", select_search));
            Params.Add(new SqlParameter("@OrderStr", select_order));
            Params.Add(new SqlParameter("@PageNo", pageno));
            Params.Add(new SqlParameter("@PageSize", pagesize));

            DataSet ds = DataAccess.SqlAccess().GetDataSet(sqltext, Params.ToArray());
            pagecount = Convert.ToInt32(paraPageCount.Value);
            recordcount = Convert.ToInt32(recordscnt.Value);
            List<Model.Notice> list = new List<Model.Notice>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                Model.Notice obj = new Model.Notice();
                Type t = obj.GetType();
                foreach (DataColumn dc in dr.Table.Columns)
                {
                    if (object.Equals(DBNull.Value, dr[dc.ColumnName]))
                        continue;
                    t.GetProperty(dc.ColumnName).SetValue(obj, Convert.ChangeType(dr[dc.ColumnName], t.GetProperty(dc.ColumnName).PropertyType), null);
                }
                list.Add(obj);
            }
            return list;
        }
    }
}
