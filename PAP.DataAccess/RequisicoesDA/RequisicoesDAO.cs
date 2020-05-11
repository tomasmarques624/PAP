using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.DataAccess.RequisicoesDA
{
    public class RequisicoesDAO
    {
        public static List<Requisicoes> GetRequisicoes()
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetRequisicoes";
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<Requisicoes> listRequisicoes = new List<Requisicoes>();
                            while (dataReader.Read())
                            {
                                var estado = dataReader["estado"].ToString();
                                if (estado == "0")
                                {
                                    listRequisicoes.Add(new Requisicoes()
                                    {
                                        id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                        data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                        data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                        estado = false,
                                        id_user = Convert.ToInt32(dataReader["id_user"]),
                                        id_equip = Convert.ToInt32(dataReader["id_equip"])
                                    });
                                }
                                else
                                {
                                    listRequisicoes.Add(new Requisicoes()
                                    {
                                        id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                        data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                        data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                        estado = true,
                                        id_user = Convert.ToInt32(dataReader["id_user"]),
                                        id_equip = Convert.ToInt32(dataReader["id_equip"])
                                    });
                                }
                            }
                            return listRequisicoes;
                        }
                        return null;
                    }
                }
            }
        }
        public static List<Requisicoes> GetUserReq(int id_user)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetUserReq";
                    command.Parameters.AddWithValue("@id_user", id_user);
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<Requisicoes> listRequisicoes = new List<Requisicoes>();
                            while (dataReader.Read())
                            {
                                listRequisicoes.Add(new Requisicoes()
                                {
                                    id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                    data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                    data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                    estado = Convert.ToBoolean(dataReader["estado"].ToString()),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                            return listRequisicoes;
                        }
                        return null;
                    }
                }
            }
        }

        public static int UpdateReqEstado(int id_req, bool estado)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateReqEstado";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_req", id_req);
                    command.Parameters.AddWithValue("@estado", estado);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static Requisicoes GetRequisicaoByID(int id_requisicao)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetRequisicaoByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_requisicao", id_requisicao);
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
                                Requisicoes requisicao = new Requisicoes()
                                {
                                    id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                    data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                    data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                    estado = Convert.ToBoolean(dataReader["estado"].ToString()),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                };
                                return requisicao;
                            }
                        }
                        return null;
                    }
                }
            }
        }

        public static int RemoveRequisicao(int id_requisicao)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_DeleteRequisicaoByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_requisicao", id_requisicao);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static int InsertReq(Requisicoes req)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_InsertRequisicao";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_user", req.id_user);
                    command.Parameters.AddWithValue("@id_equip", req.id_equip);
                    command.Parameters.AddWithValue("@data_requisicao", req.data_requisicao);
                    command.Parameters.AddWithValue("@data_requisicao_final", req.data_requisicao_final);
                    command.Parameters.AddWithValue("@estado", req.estado);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
    }
}
