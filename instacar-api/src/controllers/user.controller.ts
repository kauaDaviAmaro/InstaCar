import { Request, Response } from 'express';
import { IAuthRequest, IUser } from '../types';
import { createUser, getUserById } from '../services/user.service';
import { MESSAGES } from '../utils/messages';

export const register = async (
  req: Request<{}, {}, IUser>,
  res: Response
): Promise<void> => {
  try {
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
        nome: user?.nome,
        email: user?.email,
        fotoPerfil: user?.fotoPerfil,
      }
    });
  } catch (error) {
    res.status(500).json({ message: MESSAGES.GENERAL.SERVER_ERROR });
  }
};
