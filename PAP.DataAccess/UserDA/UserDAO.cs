using PAP.Models;
using PAP.DataAccess.CryptoHelpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace PAP.DataAccess.UserDA
{
    public class UserDAO
    {
        public static List<User> GetUsers()
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetUsers";
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<User> listUsers = new List<User>();
                            while (dataReader.Read())
                            {
                                listUsers.Add(new User()
                                {
                                    id_User = Convert.ToInt32(dataReader["id_user"]),
                                    Username = dataReader["username"].ToString(),
                                    Email = dataReader["email"].ToString(),
                                    isloocked = Convert.ToBoolean(dataReader["is_looked"])
                                });
                            }
                            return listUsers;
                        }
                        return null;
                    }
                }
            }
        }
        public static int UpdateUser(User user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateUserByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_user", user.id_User);
                    command.Parameters.AddWithValue("@username", user.Username);
                    command.Parameters.AddWithValue("@password", user.Password);
                    command.Parameters.AddWithValue("@email", user.Email);
                    command.Parameters.AddWithValue("@role", user.Role);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static int RemoveUser(int id_user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_DeleteUserByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_user", id_user);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int UnlockUser(int id_user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UnlockUser";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_user", id_user);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static int LockUser(int id_user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_LockUser";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_user", id_user);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static int RegisterUser(User user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_InsertUser";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@username", user.Username);
                    command.Parameters.AddWithValue("@password", PasswordEncryptSHA256.GenerateSHA256String(user.Password));
                    command.Parameters.AddWithValue("@email", user.Email);
                    command.Parameters.AddWithValue("@role", 'U');
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static User GetUserByID(int id_user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetUserByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_user", id_user);
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
                                User user = new User()
                                {
                                    id_User = Convert.ToInt32(dataReader["id_user"]),
                                    Password = dataReader["password"].ToString(),
                                    Username = dataReader["username"].ToString(),
                                    Email = dataReader["email"].ToString(),
                                    Role = dataReader["role"].ToString()[0],
                                    isloocked = Convert.ToBoolean(dataReader["is_looked"]),
                                    nr_attempts = Convert.ToInt32(dataReader["nr_attempts"]),
                                    locked_date_time = dataReader["locked_date_time"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dataReader["locked_date_time"])
                                };
                                return user;
                            }
                        }
                        return null;
                    }
                }
            }
        }
        public static User GetUserByEmail(string email)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetUserByEmail";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            User user = new User();
                            while (dataReader.Read())
                            {
                                user = new User()
                                {
                                    id_User = Convert.ToInt32(dataReader["id_user"]),
                                    Username = dataReader["username"].ToString(),
                                    Email = dataReader["email"].ToString()
                                };
                            }
                            return user;
                        }
                        return null;
                    }
                }
            }
        }

        public static User GetUser(string username, string password)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_AuthenticateUser";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@username", username);
                    command.Parameters.AddWithValue("@password", PasswordEncryptSHA256.GenerateSHA256String(password));
                    connection.Open();
                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.Read())
                        {
                            User user = new User()
                            {
                                id_User = Convert.ToInt32(dataReader["id_user"]),
                                Username = dataReader["username"].ToString(),
                                Password = dataReader["password"].ToString(),
                                Email = dataReader["email"].ToString(),
                                Role = dataReader["role"].ToString()[0],
                                isloocked = Convert.ToBoolean(dataReader["is_looked"]),
                                nr_attempts = Convert.ToInt32(dataReader["nr_attempts"]),
                                locked_date_time = dataReader["locked_date_time"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dataReader["locked_date_time"])
                            };
                            return user;
                        }
                        return null;
                    }
                }
            }
        }
    }
}