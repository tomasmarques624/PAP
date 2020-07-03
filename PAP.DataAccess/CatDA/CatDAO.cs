using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.DataAccess.CatDA
{
    public class CatDAO
    {
        public static List<Categoria> GetCats()
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetCats";
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<Categoria> listCats = new List<Categoria>();
                            while (dataReader.Read())
                            {
                                listCats.Add(new Categoria()
                                {
                                    Nome = dataReader["Nome"].ToString(),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"])
                                });
                            }
                            return listCats;
                        }
                        return null;
                    }
                }
            }
        }
        public static int UpdateCat(Categoria cat)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateCatByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_cat", cat.id_cat);
                    command.Parameters.AddWithValue("@Nome", cat.Nome);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static Categoria GetCatByID(int id_cat)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetCatByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_cat", id_cat);
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
                                Categoria cat = new Categoria()
                                {
                                    Nome = dataReader["Nome"].ToString(),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"])
                                };
                                return cat;
                            }
                        }
                        return null;
                    }
                }
            }
        }

        public static int RemoveCat(int id_cat)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_DeleteCatByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_cat", id_cat);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int InsertCat(Categoria cat)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_InsertCategoria";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Nome", cat.Nome);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
    }
}
