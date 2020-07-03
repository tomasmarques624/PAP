using PAP.Models;
using PAP.DataAccess.CryptoHelpers;
using PAP.DataAccess.UserDA;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace PAP.DataAccess.PasswordDA
{
    public class PasswordDAO
    {
        public static string InsertNewResetPwdRequest(string email)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_InsertPwdRequest";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@email", email);

                    connection.Open();
                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.Read())
                        {
                            return dataReader["guid"].ToString();
                        }
                        return null;
                    }
                }
            }
        }
        public static int ResetPassword(int id_user, string new_password)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_ResetPassword";
                    command.Parameters.AddWithValue("@id_user", id_user);
                    command.Parameters.AddWithValue("@new_password", PasswordEncryptSHA256.GenerateSHA256String(new_password));
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static ResetPwdRequests GetNewPwdRequestDataByGUID(string guid)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetPwdRequestDataByGUID";
                    command.Parameters.AddWithValue("@guid", guid);
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.Read())
                        {
                            if (Convert.ToInt32(dataReader["ReturnCode"]) == -1)
                            {
                                return null;
                            }
                            if (dataReader.NextResult())
                            {
                                dataReader.Read();
                                ResetPwdRequests pwdRequests = new ResetPwdRequests()
                                {
                                    id_resetPwdRequest = Convert.ToInt32(dataReader["id_resetPwdRequest"]),
                                    email = dataReader["email"].ToString(),
                                    guid = dataReader["guid"].ToString(),
                                    date_recovery_request = Convert.ToDateTime(dataReader["date_recovery_request"].ToString())
                                };
                                return pwdRequests;
                            }
                        }
                        return null;
                    }
                }
            }
        }
        public static int DeletePwdRequestByEmail(string email)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_DeletePwdRequestByEmail";
                    command.Parameters.AddWithValue("@email", email);
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
    }
}
