import { Request, Response } from 'express';
import { IAuthRequest, IUser } from '../types';
import { createUser, getUserById } from '../services/user.service';
import { MESSAGES } from '../utils/messages';
import User from '../models/User';

export const register = async (
  req: Request<{}, {}, IUser>,
  res: Response
): Promise<void> => {
  try {
    console.log('Registering user:', req.body);
    const newUser = await createUser(req.body);
    res
      .status(201)
      .json({ message: MESSAGES.USER.SUCCESS, userId: newUser.id });
  } catch (error: any) {
    if (error.message === 'INVALID_USER') {
      res.status(401).json({ message: MESSAGES.USER.INVALID_USER });
      return;
    }
    res.status(500).json({ message: MESSAGES.USER.ERROR });
  }
};

export const updateUser = async (req: IAuthRequest, res: Response) => {
  try {
    const userId = req.user?.userId; // A partir do middleware authMiddleware
    const updatedData = req.body;

    const updatedUser = await User.update(updatedData, {
      where: { id: userId },
    });

    res.status(200).json({ message: 'Usuário atualizado com sucesso', updatedUser });
  } catch (error) {
    res.status(500).json({ error: 'Erro ao atualizar usuário' });
  }
};


export const getUser = async (
  req: IAuthRequest,
  res: Response
): Promise<void> => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      res.status(401).json({ message: MESSAGES.USER.NOT_FOUND });
      return;
    }

    const user = await getUserById(userId);

    res.json({
      user: {
        id: user?.id,
        name: user?.name,
        email: user?.email,
        fotoPerfil: user?.fotoPerfil,
      }
    });
  } catch (error) {
    res.status(500).json({ message: MESSAGES.GENERAL.SERVER_ERROR });
  }
};
