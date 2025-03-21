import { Request, Response } from "express";
import { getAllCaronas } from "../services/carona.service";

export const getCaronas = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const caronas = await getAllCaronas();

    res.json(caronas);
  } catch (error) {
    res.status(500).json({ message: "Erro ao buscar caronas" });
  }
};
