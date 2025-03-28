import { Router } from "express";
import {
  createCarona,
  deleteCarona,
  getCaronas,
  getNearCaronas,
  updateCarona,
  updateCaronaStatus,
} from "../controllers/carona.controller";

const caronaRoutes = Router();

/**
 * @swagger
 * /caronas:
 *   get:
 *     summary: Get all caronas
 *     tags: [Caronas]
 *     responses:
 *       200:
 *         description: List of all caronas
 */
caronaRoutes.get("/", getCaronas);

caronaRoutes.get("/:id", getCaronas);

caronaRoutes.get("/near/:latitude/:longitude", getNearCaronas);

caronaRoutes.post("/", createCarona);

caronaRoutes.delete("/:id", deleteCarona);

caronaRoutes.put("/:id", updateCarona);

caronaRoutes.put("/:id/:status", updateCaronaStatus);

export default caronaRoutes;
