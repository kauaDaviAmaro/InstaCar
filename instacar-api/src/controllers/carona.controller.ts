import { Request, Response } from "express";
import CaronaService from "../services/carona.service";
import { MESSAGES } from "../utils/messages";

export const getCaronas = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const caronas = await CaronaService.getAllCaronas();

    res.json(caronas);
  } catch (error) {
    res.status(500).json({ message: MESSAGES.GENERAL.SERVER_ERROR });
  }
};

export const createCarona = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const newCarona = CaronaService.createCarona(req.body);

    res.status(201).json(newCarona);
  } catch (error) {
    res.status(500).json({ message: MESSAGES.CARONA.ERROR });
  }
};

export const deleteCarona = async (
  req: Request,
  res: Response
): Promise<void> => {};

export const updateCarona = async (
  req: Request,
  res: Response
): Promise<void> => {};

export const updateCaronaStatus = async (
  req: Request,
  res: Response
): Promise<void> => {};

export const getNearCaronas = async (
  req: Request,
  res: Response
): Promise<void> => {};
