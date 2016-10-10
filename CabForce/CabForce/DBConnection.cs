using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace CabForce
{
    public class DBConnection : System.Web.UI.Page
    {
        public void ExecuteNonQuery(string query)
        {
            try
            {
                string conString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
                SqlConnection con = new SqlConnection(conString);
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
                con.Close();
                con.Dispose();
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }
        }

        public void ExecuteNonQuery(string strQuery, SqlParameter[] param)
        {
            try
            {
                string conString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
                SqlConnection con = new SqlConnection(conString);
                if (con.State != ConnectionState.Open)
                    con.Open();

                SqlCommand cmd = new SqlCommand(strQuery, con);
                AttachParameters(cmd, param);
                string query = cmd.CommandText;
                foreach (SqlParameter p in cmd.Parameters)
                {
                    query = query.Replace(p.ParameterName, p.Value.ToString());
                }
                cmd.ExecuteNonQuery();


                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    con.Dispose();
                }
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }
        }
        private static void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
        {
            try
            {
                if (command == null) throw new ArgumentNullException("command");
                if (commandParameters != null)
                {
                    foreach (SqlParameter p in commandParameters)
                    {
                        if (p != null)
                        {
                            // Check for derived output value with no value assigned
                            if ((p.Direction == ParameterDirection.InputOutput ||
                                p.Direction == ParameterDirection.Input) &&
                                (p.Value == null))
                            {
                                p.Value = DBNull.Value;
                            }
                            command.Parameters.Add(p);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace);
            }
        }

        public DataSet GetData(string query)
        {
            string conString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            DataSet Ds = new DataSet();
            SqlConnection con = new SqlConnection(conString);
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(Ds);
                con.Close();
                con.Dispose();
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }
            return Ds;
          
        }
        public SqlDataReader SqlDataReader(string query)
        {
            string conString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            SqlDataReader dr = null;
            try
            {

                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                dr = cmd.ExecuteReader();
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }

            return dr;

        }
        public SqlDataReader SqlDataReader(string strQuery, SqlParameter[] param)
        {
            string conString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            SqlDataReader dr = null;
            try
            {
                if (con.State != ConnectionState.Open)
                    con.Open();
                SqlCommand cmd = new SqlCommand(strQuery, con);

                AttachParameters(cmd, param);
                dr = cmd.ExecuteReader();
            }
            catch (Exception ex)
            {
                new Error().LogErrors(ex.Message, ex.StackTrace, Page);
            }
            return dr;

        }
        public int SqlExecuteScalar(string strQuery, SqlParameter[] param)
        {
            string conString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            SqlConnection con = new SqlConnection(conString);
            int returnPkId = 0;

            if (con.State != ConnectionState.Open)
                con.Open();

            object objRet = ExecuteScalar(con, CommandType.Text, strQuery, param);
            int.TryParse(Convert.ToString(objRet), out returnPkId);

            if (con.State == ConnectionState.Open)
            {
                con.Close();
                con.Dispose();
            }

            return returnPkId;
        }

        public static object ExecuteScalar(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            if (connection == null) throw new ArgumentNullException("connection");

            // Create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();

            bool mustCloseConnection = false;
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters, out mustCloseConnection);

            // Execute the command & return the results
            object retval = cmd.ExecuteScalar();

            // Detach the SqlParameters from the command object, so they can be used again
            cmd.Parameters.Clear();

            if (mustCloseConnection)
                connection.Close();
            connection.Dispose();
            return retval;
        }
        private static void PrepareCommand(SqlCommand command, SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText, SqlParameter[] commandParameters, out bool mustCloseConnection)
        {
            if (command == null) throw new ArgumentNullException("command");
            if (commandText == null || commandText.Length == 0) throw new ArgumentNullException("commandText");

            // If the provided connection is not open, we will open it
            if (connection.State != ConnectionState.Open)
            {
                mustCloseConnection = true;
                connection.Open();
            }
            else
            {
                mustCloseConnection = false;
            }

            // Associate the connection with the command
            command.Connection = connection;

            // Set the command text (stored procedure name or SQL statement)
            command.CommandText = commandText;

            // If we were provided a transaction, assign it
            if (transaction != null)
            {
                if (transaction.Connection == null) throw new ArgumentException("The transaction was rollbacked or commited, please provide an open transaction.", "transaction");
                command.Transaction = transaction;
            }

            // Set the command type
            command.CommandType = commandType;

            // Attach the command parameters if they are provided
            if (commandParameters != null)
            {
                AttachParameters(command, commandParameters);
            }
            return;
        }

    }
}