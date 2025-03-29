import { Router } from "express";
import { getChatHistory } from "../controllers/chat.controller";

const router = Router();

/**
 * @swagger
 * /chat/{caronaId}:
 *   get:
 *     summary: Retrieve chat history for a specific carona
 *     parameters:
 *       - in: path
 *         name: caronaId
 *         required: true
 *         schema:
 *           type: string
 *         description: The ID of the carona
 *     responses:
 *       200:
 *         description: A list of chat messages
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   sender:
 *                     type: string
 *                   message:
 *                     type: string
 *                   timestamp:
 *                     type: string
 *                     format: date-time
 *       404:
 *         description: Carona not found
 *       500:
 *         description: Internal server error
 */
router.get("/:caronaId", getChatHistory);

export default router;
