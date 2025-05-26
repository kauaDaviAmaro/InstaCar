import { Router } from "express";
import { submitFeedback } from '../controllers/feedback.controller';

const router = Router();

/**
 * @swagger
 * /feedback:
 *   post:
 *     summary: Submit user feedback
 *     tags:
 *       - Feedback
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               message:
 *                 type: string
 *                 example: "Great app!"
 *               rating:
 *                 type: integer
 *                 example: 5
 *     responses:
 *       200:
 *         description: Feedback submitted successfully
 *       400:
 *         description: Invalid input
 */
router.post('/', submitFeedback);

export default router;
