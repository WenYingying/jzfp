using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

using System.Configuration;
using System.Data.SqlClient;

namespace DAL
{
    public class SQLHelpers
    {
        public string connStr;
        private SqlConnection conn;

        public SQLHelpers()
        {
            //connStr = ConfigurationManager.AppSettings["SQLConnStr"].Trim();
        }

        private void Open()
        {
            if (conn == null)
            {
                conn = new SqlConnection(connStr);
            }
            if (conn.State == ConnectionState.Closed)
                conn.Open();
        }

        private void Close()
        {
            if (conn != null)
            {
                conn.Close();
                conn.Dispose();
            }
        }

        private SqlCommand PrepareCmd(string Procedure, SqlParameter[] Params,CommandType cmdType)
        {
            Open();
            SqlCommand cmd = new SqlCommand(Procedure, conn);
            cmd.CommandType = cmdType;
            foreach (SqlParameter p in Params)
            {
                cmd.Parameters.Add(p);
            }
            return cmd;
        }

        private SqlCommand PrepareCmd(string SqlCmdText)
        {
            Open();
            SqlCommand cmd = new SqlCommand(SqlCmdText, conn);
            return cmd;
        }

        private SqlDataAdapter PrepareAdapter(string SqlCmdText)
        {
            Open();
            SqlDataAdapter da = new SqlDataAdapter(SqlCmdText, conn);
            return da;
        }

        private SqlDataAdapter PrepareAdapter(string SqlCmdText, SqlParameter[] Params)
        {
            Open();
            SqlDataAdapter da = new SqlDataAdapter(SqlCmdText, conn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter p in Params)
            {
                da.SelectCommand.Parameters.Add(p);
            }
            return da;
        }

        public int ExecuteNonQuery(string SqlCmdText)
        {
            try
            {
                SqlCommand cmd = PrepareCmd(SqlCmdText);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                Close();
            }
        }

        public int ExecuteNonQuery(string Procedure, SqlParameter[] Params,CommandType cmdType)
        {
            try
            {
                SqlCommand cmd = PrepareCmd(Procedure, Params,cmdType);
                int result = cmd.ExecuteNonQuery();
                Close();
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                Close();
            }
        }

        public SqlDataReader ExecuteReader(string SqlCmdText)
        {
            return PrepareCmd(SqlCmdText).ExecuteReader(CommandBehavior.CloseConnection);

        }

        public SqlDataReader ExecuteReader(string Procedure, SqlParameter[] Params,CommandType cmdType)
        {
            return PrepareCmd(Procedure, Params,cmdType).ExecuteReader(CommandBehavior.CloseConnection);
        }

        public object ExecuteScalar(string SqlCmdText)
        {
            try
            {
                SqlCommand cmd = PrepareCmd(SqlCmdText);
                return cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                Close();
            }
        }

        public object ExecuteScalar(string Procedure, SqlParameter[] Params,CommandType cmdType)
        {
            try
            {
                SqlCommand cmd = PrepareCmd(Procedure, Params,cmdType);
                return cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                Close();
            }
        }

        public DataSet GetDataSet(string SqlCmdText)
        {
            try
            {
                DataSet ds = new DataSet();
                using (SqlDataAdapter da = PrepareAdapter(SqlCmdText))
                {
                    da.Fill(ds);
                }
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        public DataSet GetDataSet(string SqlCmdText, SqlParameter[] Params)
        {
            try
            {
                DataSet ds = new DataSet();
                using (SqlDataAdapter da = PrepareAdapter(SqlCmdText, Params))
                {
                    da.Fill(ds);
                }
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

    }

}
