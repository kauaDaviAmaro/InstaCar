import { DataTypes, Model } from "sequelize";
import sequelize from "../config/db";
import { ICarona } from "../types";

class Carona extends Model<ICarona> {
  public id!: string;
  public motoristaId!: string;
  public origem!: string;
  public destino!: string;
  public dataHora!: string;
  public vagas!: number;
  public status?: "disponível" | "lotada" | "finalizada";
  public origem_lat?: number;
  public origem_lon?: number;

  // timestamps!
  public readonly createdAt!: Date;
  public readonly updatedAt!: Date;
}

Carona.init(
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    motoristaId: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: "Motorista",
        key: "id",
      },
    },
    origem: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    destino: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    dataHora: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    vagas: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    status: {
      type: DataTypes.ENUM("disponível", "lotada", "finalizada"),
      defaultValue: "disponível",
    },
    origem_lat: {
      type: DataTypes.FLOAT,
      allowNull: true,
    },
    origem_lon: {
      type: DataTypes.FLOAT,
      allowNull: true,
    },
    destino_lat: {
      type: DataTypes.FLOAT,
      allowNull: true,
    },
    destino_lon: {
      type: DataTypes.FLOAT,
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: "Carona",
  }
);

export default Carona;
