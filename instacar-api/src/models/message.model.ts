import { DataTypes } from "sequelize";
import sequelize from "../config/db";
import Conversation from "./conversation.model";

const Message = sequelize.define("Message", {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  conversationId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  senderId: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  message: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
}, {
  timestamps: true,
});

Message.belongsTo(Conversation, { foreignKey: 'conversationId' });

export default Message;
