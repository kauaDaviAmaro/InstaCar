import { DataTypes, Model } from "sequelize";
import sequelize from "../config/db";
import { IChat } from "../interfaces/chat.interface";

class Chat extends Model<IChat> {
  public id!: number;
  public caronaId!: number;
  public userId!: number;
  public message!: string;
  public timestamp!: Date;
}

Chat.init(
  {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    caronaId: { type: DataTypes.INTEGER, allowNull: false },
    userId: { type: DataTypes.INTEGER, allowNull: false },
    message: { type: DataTypes.TEXT, allowNull: false },
    timestamp: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  },
  {
    sequelize,
    tableName: "chats",
  }
);

export default Chat;