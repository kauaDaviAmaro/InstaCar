import { Request } from "express";

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
  id?: string;
  motoristaId?: string;
  pontoInicio: string;
  pontoFinal: string;
  observacao?: string;
  dataHora: string;
  recorrente?: boolean;
  status?: "disponível" | "em andamento" | "concluída" | "cancelada";
}

export interface IMotorista {
  id?: string;
  usuarioId: string;
  cnh: string;
  tipoVeiculo: string;
  corVeiculo?: string;
  placa: string;
  verificado?: boolean;
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