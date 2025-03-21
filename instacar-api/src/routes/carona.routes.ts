import { Router } from 'express';
import { getCaronas } from '../controllers/carona.controller';

const caronaRoutes = Router();

/**
 * @swagger
 * tags:
 *   name: Caronas
 *   description: API for managing caronas
 */

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
caronaRoutes.get('/', getCaronas);

export default caronaRoutes;