// controllers/chat.controller.ts
import { Op, Model } from "sequelize";
import Conversation from "../models/conversation.model";
import Message from "../models/message.model";

export const getOrCreateConversation = async (user1Id: string, user2Id: string): Promise<Model & { id: string }> => {
  const [conversation] = await Conversation.findOrCreate({
    where: {
      [Op.or]: [
        { user1Id, user2Id },
        { user1Id: user2Id, user2Id: user1Id },
      ],
    },
  });

  return conversation as Model & { id: string };
};

export const sendMessage = async (senderId: string, receiverId: string, text: string) => {
  const conversation = await getOrCreateConversation(senderId, receiverId);

  const message = await Message.create({
    conversationId: conversation.id,
    senderId,
    message: text,
  });

  return message;
};

export const listUserConversations = async (userId: string) => {
  const conversations = await Conversation.findAll({
    where: {
      [Op.or]: [
        { user1Id: userId },
        { user2Id: userId },
      ],
    },
    include: [{
      model: Message,
      order: [['createdAt', 'DESC']],
      limit: 1,
    }],
  });

  return conversations;
};

export const getConversationMessages = async (conversationId: string) => {
  const messages = await Message.findAll({
    where: {
      conversationId: conversationId,
    },
    order: [['createdAt', 'ASC']],
  });

  return messages;
};