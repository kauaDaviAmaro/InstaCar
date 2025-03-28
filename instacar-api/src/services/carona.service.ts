import { FindOptions, WhereOptions } from "sequelize";
import {
  CaronaFilter,
  CreateCaronaDTO,
  ICaronaService,
  UpdateCaronaDTO,
} from "../interfaces/carona-service.interface";
import Carona from "../models/carona";
import { ICarona } from "../types";

const CaronaService: ICaronaService =  {
  async createCarona(data: CreateCaronaDTO): Promise<Carona> {
    const carona = await Carona.create(data);
    return carona;
  },

  async getCaronaById(id: string): Promise<Carona | null> {
    const carona = await Carona.findByPk(id);
    return carona;
  },

  async listCaronas(filter?: CaronaFilter): Promise<Carona[]> {
    const whereClause: FindOptions<ICarona> = filter ? { where: filter as WhereOptions<ICarona> } : {};
    const caronas = await Carona.findAll(whereClause);
    return caronas;
  },

  async updateCarona(id: string, data: UpdateCaronaDTO): Promise<Carona> {
    const carona = await Carona.findByPk(id);
    if (!carona) {
      throw new Error("Carona not found");
    }
    await carona.update(data);
    return carona;
  },

  async deleteCarona(id: string): Promise<void> {
    const carona = await Carona.findByPk(id);
    if (!carona) {
      throw new Error("Carona not found");
    }
    await carona.destroy();
  },

  async getAllCaronas() {
    const caronas = await Carona.findAll();
    return caronas;
  },

  async updateCaronaStatus(id: string, status: string): Promise<Carona> {
    const carona = await Carona.findByPk(id);
    if (!carona) {
      throw new Error("Carona not found");
    }
    carona.status = status as "disponível" | "lotada" | "finalizada";
    await carona.save();
    return carona;
  },

  async getNearCaronas(latitude: number, longitude: number): Promise<Carona[]> {
    const caronas = await Carona.findAll({
      where: {
        origem_lat: { $near: latitude },
        origem_lon: { $near: longitude },
      },
    });
    return caronas;
  }
}

export default CaronaService;
