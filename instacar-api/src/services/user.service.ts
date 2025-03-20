import bcrypt from 'bcryptjs';
import User from '../models/User';
import { IUser } from '../types';

export const createUser = async (userData: IUser) => {
  const { nome, email, senha } = userData;

  if (!nome || !email || !senha) {
    throw new Error('INVALID_USER');
  }

  const hashedPassword = await bcrypt.hash(senha, 10);

  return User.create({ nome, email, senha: hashedPassword });
};

export const getUserById = async (id: string) => {
  const user = await User.findOne({ where: { id } });

  if (!user) {
    throw new Error('INVALID_USER');
  }

  return user;
};

export const getUserByEmail = async (email: string) => {
  const user = await User.findOne({ where: { email } });

  if (!user) {
    throw new Error('INVALID_USER');
  }

  return user;
}