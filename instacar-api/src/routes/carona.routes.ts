import { Router } from "express";
import caronaController from "../controllers/carona.controller";

const caronaRoutes = Router();

/**
 * @swagger
 * /carona:
 *   get:
 *     summary: Retrieve a list of all caronas
 *     tags: [Caronas]
 *     responses:
 *       200:
 *         description: A list of caronas
 *   post:
 *     summary: Create a new carona
 *     tags: [Caronas]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               // Define the properties of the carona object here
 *     responses:
 *       201:
 *         description: Carona created successfully
 * 
 * /carona/{id}:
 *   get:
 *     summary: Retrieve a specific carona by ID
 *     tags: [Caronas]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The carona ID
 *     responses:
 *       200:
 *         description: A specific carona
 *   delete:
 *     summary: Delete a specific carona by ID
 *     tags: [Caronas]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The carona ID
 *     responses:
 *       200:
 *         description: Carona deleted successfully
 *   put:
 *     summary: Update a specific carona by ID
 *     tags: [Caronas]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The carona ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               // Define the properties of the carona object here
 *     responses:
 *       200:
 *         description: Carona updated successfully
 * 
 * /carona/near/{latitude}/{longitude}:
 *   get:
 *     summary: Retrieve caronas near a specific location
 *     tags: [Caronas]
 *     parameters:
 *       - in: path
 *         name: latitude
 *         required: true
 *         schema:
 *           type: number
 *         description: Latitude of the location
 *       - in: path
 *         name: longitude
 *         required: true
 *         schema:
 *           type: number
 *         description: Longitude of the location
 *     responses:
 *       200:
 *         description: A list of nearby caronas
 * 
 * /carona/{id}/{status}:
 *   put:
 *     summary: Update the status of a specific carona by ID
 *     tags: [Caronas]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The carona ID
 *       - in: path
 *         name: status
 *         required: true
 *         schema:
 *           type: string
 *         description: The new status of the carona
 *     responses:
 *       200:
 *         description: Carona status updated successfully
 */


caronaRoutes.get("/", caronaController.getCaronas);

caronaRoutes.get("/:id", caronaController.getCaronaById);

caronaRoutes.get("/near/:latitude/:longitude", caronaController.getNearCaronas);

caronaRoutes.post("/", caronaController.createCarona);

caronaRoutes.delete("/:id", caronaController.deleteCarona);

caronaRoutes.put("/:id", caronaController.updateCarona);

caronaRoutes.put("/:id/:status", caronaController.updateCaronaStatus);

export default caronaRoutes;
