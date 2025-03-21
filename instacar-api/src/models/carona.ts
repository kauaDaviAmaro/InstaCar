import { DataTypes, Model } from "sequelize";
import sequelize from "../config/db";
import { ICarona } from "../types";

class Carona extends Model<ICarona> {
  id?: string;
  motoristaId?: string;
  pontoInicio!: string;
  pontoFinal!: string;
  observacao?: string;
  dataHora!: string;
  recorrente?: boolean;
  status?: "disponível" | "em andamento" | "concluída" | "cancelada";
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
    },
    pontoInicio: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    pontoFinal: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    observacao: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    dataHora: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    recorrente: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    status: {
      type: DataTypes.ENUM(
        "disponível",
        "em andamento",
        "concluída",
        "cancelada"
      ),
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: "Carona",
  }
);

export default Carona;
