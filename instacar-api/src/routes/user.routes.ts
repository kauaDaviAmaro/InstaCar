import express from 'express';
import { register, getUser } from '../controllers/user.controller';
import authMiddleware from '../middlewares/Auth';

const router = express.Router();

/**
 * @swagger
 * /users/register:
 *   post:
 *     summary: Registra um novo usuário
 *     description: Cria um novo usuário com nome, e-mail e senha.
 *     tags:
 *       - Usuários
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               nome:
 *                 type: string
 *                 example: João Silva
 *               email:
 *                 type: string
 *                 example: joao@email.com
 *               senha:
 *                 type: string
 *                 example: 123456
 *     responses:
 *       201:
 *         description: Usuário cadastrado com sucesso
 *       500:
 *         description: Erro ao cadastrar usuário
 */
router.post('/register', register);

/**
 * @swagger
 * /users/:
 *   get:
 *     summary: Obtém os dados do usuário autenticado
 *     description: Retorna informações do usuário autenticado com base no token JWT enviado.
 *     tags:
 *       - Usuários
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: Dados do usuário retornados com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Acesso autorizado"
 *                 user:
 *                   type: object
 *                   properties:
 *                     userId:
 *                       type: string
 *                       example: "123456"
 *       401:
 *         description: Token inválido ou não fornecido
 *       403:
 *         description: Acesso negado, sem token válido
 */
router.get('/', authMiddleware, getUser);

export default router;
