using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.DataAccess.DenunciasDA
{
    public class DenunciasDAO
    {
        public static List<Denuncias> GetDenuncias()
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetDenuncias";
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<Denuncias> listDenuncias = new List<Denuncias>();
                            while (dataReader.Read())
                            {
                                listDenuncias.Add(new Denuncias()
                                {
                                    problema = dataReader["problema"].ToString(),
                                    estado = Convert.ToChar(dataReader["estado"].ToString()),
                                    prioridade = Convert.ToChar(dataReader["prioridade"].ToString()),
                                    id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                            return listDenuncias;
                        }
                        return null;
                    }
                }
            }
        }

        public static List<Denuncias> GetUserDenu(int id_user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetUserDenu";
                    command.Parameters.AddWithValue("@id_user", id_user);
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<Denuncias> listDenuncias = new List<Denuncias>();
                            while (dataReader.Read())
                            {
                                listDenuncias.Add(new Denuncias()
                                {
                                    problema = dataReader["problema"].ToString(),
                                    estado = Convert.ToChar(dataReader["estado"].ToString()),
                                    id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                    data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                            return listDenuncias;
                        }
                        return null;
                    }
                }
            }
        }

        public static int InsertDenu(Denuncias denu)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_InsertDenuncia";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_user", denu.id_user);
                    command.Parameters.AddWithValue("@id_equip", denu.id_equip);
                    command.Parameters.AddWithValue("@estado", denu.estado);
                    command.Parameters.AddWithValue("@prioridade", denu.prioridade);
                    command.Parameters.AddWithValue("@problema", denu.problema);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static int UpdateDenuEstado(int id_denu, char estado)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateDenuEstado";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_denu", id_denu);
                    command.Parameters.AddWithValue("@estado", estado);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int UpdateComentarios(int id_denu, string comentarios)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateComentarios";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_denu", id_denu);
                    command.Parameters.AddWithValue("@comentarios", comentarios);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int UpdateDenuPrio(int id_denu, char prio)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateDenuPrio";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_denu", id_denu);
                    command.Parameters.AddWithValue("@prio", prio);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static Denuncias GetDenunciaByID(int id_denuncia)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetDenunciaByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_denuncia", id_denuncia);
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
                                Denuncias denuncia = new Denuncias()
                                {
                                    problema = dataReader["problema"].ToString(),
                                    estado = Convert.ToChar(dataReader["estado"].ToString()),
                                    prioridade = Convert.ToChar(dataReader["prioridade"].ToString()),
                                    id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"]),
                                    comentarios = dataReader["comentarios"].ToString()
                                };
                                return denuncia;
                            }
                        }
                        return null;
                    }
                }
            }
        }
        public static int RemoveDenuncia(int id_denuncia)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_DeleteDenunciaByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_denuncia", id_denuncia);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
    }
}
