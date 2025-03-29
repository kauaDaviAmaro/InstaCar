import { Request } from 'express';

export interface IUser {
  id?: string;
  nome: string;
  email: string;
  senha: string;
  fotoPerfil?: string;
  verificationCode?: string;
  codeExpires?: number | null;
}

export interface ICarona {
  id: string;
  pontoInicio: string;
  pontoFinal: string;
  observacao?: string;
  userId: string;
}

export interface IAuthRequest extends Request {
  user?: { userId: string };
}

export interface IUserDTO {
  id: string;
  nome: string;
  email: string;
  fotoPerfil?: string;
}
