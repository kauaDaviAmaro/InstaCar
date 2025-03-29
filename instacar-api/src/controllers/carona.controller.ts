import { Request, Response } from "express";
import CaronaService from "../services/carona.service";
import { MESSAGES } from "../utils/messages";
import { IAuthRequest } from "../types";
import { CreateCaronaDTO } from "../interfaces/carona-service.interface";

const caronaController = {
  getCaronas: async (req: Request, res: Response): Promise<void> => {
    try {
      const caronas = await CaronaService.getAllCaronas();

      res.json(caronas);
    } catch (error) {
      res.status(500).json({ message: MESSAGES.GENERAL.SERVER_ERROR });
    }
  },

  getCaronaById: async (req: IAuthRequest, res: Response): Promise<void> => {
    try {
      const caronaId = req.params.id;

      const carona = await CaronaService.getCaronaById(caronaId);

      if (!carona) {
        res.status(404).json({ message: MESSAGES.CARONA.NOT_FOUND });
        return;
      }

      res.json(carona);
    } catch (error) {
      res.status(500).json({ message: MESSAGES.GENERAL.SERVER_ERROR });
    }
  },

  createCarona: async (req: IAuthRequest, res: Response): Promise<void> => {
    try {
      const createCaronaDTO: CreateCaronaDTO = {
        ...req.body,
        motoristaId: req.user?.userId,
      };

      const newCarona = await CaronaService.createCarona(createCaronaDTO);

      res.status(201).json(newCarona);
    } catch (error: any) {
      res.status(500).json({ message: error.message });
    }
  },

  deleteCarona: async (req: IAuthRequest, res: Response): Promise<void> => {
    try {
      const userId = req.user?.userId;
      if (!userId) {
        res.status(401).json({ message: MESSAGES.USER.INVALID_USER });
        return;
      }

      const caronaId = req.params.id;

      await CaronaService.deleteUserCarona(caronaId, userId);

      res.status(204).send();
    } catch (error) {
      res.status(500).json({ message: MESSAGES.CARONA.DELETE_ERROR });
    }
  },

  updateCarona: async (req: IAuthRequest, res: Response): Promise<void> => {
    try {
      const caronaId = req.params.id;
      const updatedCarona = await CaronaService.updateCarona(
        caronaId,
        req.body
      );

      res.status(200).json(updatedCarona);
    } catch (error) {
      res.status(500).json({ message: MESSAGES.CARONA.ERROR });
    }
  },

  updateCaronaStatus: async (req: IAuthRequest, res: Response): Promise<void> => {
    try {
      const caronaId = req.params.id;
      const status = req.params.status;

      const updatedCarona = await CaronaService.updateCaronaStatus(
        caronaId,
        status
      );

      res.status(200).json(updatedCarona);
    } catch (error) {
      res.status(500).json({ message: MESSAGES.CARONA.ERROR });
    }
  },

  getNearCaronas: async (req: IAuthRequest, res: Response): Promise<void> => {
    try {
      const { latitude, longitude } = req.params;

      const caronas = await CaronaService.getNearCaronas(
        parseFloat(latitude),
        parseFloat(longitude)
      );

      res.json(caronas);
    } catch (error) {
      console.log(error);
      
      res.status(500).json({ message: MESSAGES.CARONA.ERROR });
    }
  },
};

export default caronaController;
