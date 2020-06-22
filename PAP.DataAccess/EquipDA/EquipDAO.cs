using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.DataAccess.EquipDA
{
    public class EquipDAO
    {
        public static List<Equip> GetEquips()
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetEquips";
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<Equip> listEquips = new List<Equip>();
                            while (dataReader.Read())
                            {
                                listEquips.Add(new Equip()
                                {
                                    descri = dataReader["descri"].ToString(),
                                    disp = Convert.ToBoolean(dataReader["disp"]),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"]),
                                    id_sala = Convert.ToInt32(dataReader["id_sala"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                            return listEquips;
                        }
                        return null;
                    }
                }
            }
        }

        public static List<Equip> GetDispEquips()
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetDispEquips";
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            List<Equip> listEquips = new List<Equip>();
                            while (dataReader.Read())
                            {
                                listEquips.Add(new Equip()
                                {
                                    descri = dataReader["descri"].ToString(),
                                    disp = Convert.ToBoolean(dataReader["disp"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                            return listEquips;
                        }
                        return null;
                    }
                }
            }
        }

        public static Equip GetEquipByID(int id_equip)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetEquipByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_equip", id_equip);
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
                                Equip equip = new Equip()
                                {
                                    descri = dataReader["descri"].ToString(),
                                    disp = Convert.ToBoolean(dataReader["disp"].ToString()),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"]),
                                    id_sala = Convert.ToInt32(dataReader["id_sala"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                };
                                return equip;
                            }
                        }
                        return null;
                    }
                }
            }
        }
        public static Equip GetEquipByDescri(string descri)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_GetEquipByDescri";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@descri", descri);
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
                                Equip equip = new Equip()
                                {
                                    descri = dataReader["descri"].ToString(),
                                    disp = Convert.ToBoolean(dataReader["disp"].ToString()),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"]),
                                    id_sala = Convert.ToInt32(dataReader["id_sala"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                };
                                return equip;
                            }
                        }
                        return null;
                    }
                }
            }
        }

        public static int RemoveEquip(int id_equip)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_DeleteEquipByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_equip", id_equip);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int InsertEquip(Equip equip)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_InsertEquip";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@descri", equip.descri);
                    command.Parameters.AddWithValue("@disp", equip.disp);
                    command.Parameters.AddWithValue("@id_cat", equip.id_cat);
                    command.Parameters.AddWithValue("@id_sala", equip.id_sala);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int UpdateEquip(Equip equip)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateEquipByID";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_equip", equip.id_equip);
                    command.Parameters.AddWithValue("@descri", equip.descri);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int UpdateEquipCat(int id_equip, int id_cat)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateEquipCat";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_equip", id_equip);
                    command.Parameters.AddWithValue("@id_cat", id_cat);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
        public static int UpdateEquipSala(int id_equip, int id_sala)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateEquipSala";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_equip", id_equip);
                    command.Parameters.AddWithValue("@id_sala", id_sala);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }

        public static int UpdateEquipDisp(int id_equip, bool disp)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "sp_UpdateEquipDisp";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@id_equip", id_equip);
                    command.Parameters.AddWithValue("@disp", disp);
                    connection.Open();
                    int returncode = (int)command.ExecuteScalar();
                    return returncode;
                }
            }
        }
    }
}
