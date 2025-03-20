import jwt from 'jsonwebtoken';
import bcrypt from 'bcryptjs';
import { getUserByEmail } from './user.service';

export const authenticateUser = async (email: string, senha: string) => {
  const user = await getUserByEmail(email);

  if (!(await bcrypt.compare(senha, user.senha))) {
    throw new Error('INVALID_CREDENTIALS');
  }

  const token = jwt.sign(
    { userId: user.id },
    process.env.JWT_SECRET as string,
    { expiresIn: '1h' }
  );

  return token;
};

const generateCode = (): string => {
  return Math.floor(10000 + Math.random() * 90000).toString();
};

export const createRecoveryCode = async (email: string): Promise<string> => {
  const user = await getUserByEmail(email)

  const verificationCode = generateCode();
  user.verificationCode = verificationCode;
  user.codeExpires = Date.now() + 15 * 60 * 1000;

  user.save();

  return verificationCode;
};

export const verifyCode = async (
  email: string,
  code: string
): Promise<boolean | null> => {
  const user = await getUserByEmail(email);
  
  return (
    user.verificationCode === code && user.codeExpires! >= Date.now()
  );
};

export const resetUserPassword = async (
  email: string,
  newPassword: string
): Promise<boolean> => {
  const user = await getUserByEmail(email);

  const hashedPassword = await bcrypt.hash(newPassword, 10);
  user.senha = hashedPassword;

  user.verificationCode = "";
  user.codeExpires = null;

  await user.save();

  return true;
};
