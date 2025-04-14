import { Request, Response } from "express";
import Chat from "../models/Chat";

export const getChatHistory = async (req: Request, res: Response) => {
  try {
    const { caronaId } = req.params;
    const messages = await Chat.findAll({
      where: { caronaId },
      order: [["timestamp", "ASC"]],
    });

    res.json(messages);
  } catch (error) {
    res.status(500).json({ error: "Erro ao buscar mensagens do chat" });
  }
};
