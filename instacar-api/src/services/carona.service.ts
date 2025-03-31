import { FindOptions, WhereOptions } from "sequelize";
import {
  CaronaFilter,
  CreateCaronaDTO,
  ICaronaService,
  UpdateCaronaDTO,
} from "../interfaces/carona-service.interface";
import Carona from "../models/carona";
import { ICarona } from "../types";
import { validateCaronaData } from "../utils/carona-validator";

const CaronaService: ICaronaService = {
  async createCarona(data: CreateCaronaDTO): Promise<Carona> {
    validateCaronaData(data);

    const carona = await Carona.create(data);
    return carona;
  },

  async getCaronaById(id: string): Promise<Carona | null> {
    const carona = await Carona.findByPk(id);
    return carona;
  },

  async listCaronas(filter?: CaronaFilter): Promise<Carona[]> {
    const whereClause: FindOptions<ICarona> = filter
      ? { where: filter as WhereOptions<ICarona> }
      : {};
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

  async deleteUserCarona(id: string, userId: string): Promise<void> {
    const carona = await Carona.findOne({ where: { id, motoristaId: userId } });
    if (!carona) {
      throw new Error("Carona not found or you are not the owner");
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

  async getNearCaronas(
    latitude: number,
    longitude: number,
    radioKm: number = 10
  ): Promise<Carona[]> {
    const earthRadius = 6371;

    const caronas = await Carona.sequelize?.query(
      `
      SELECT * FROM (
          SELECT *, (
              ${earthRadius} * ACOS(
                  COS(RADIANS(:latitude)) * COS(RADIANS(origem_lat)) *
                  COS(RADIANS(origem_lon) - RADIANS(:longitude)) +
                  SIN(RADIANS(:latitude)) * SIN(RADIANS(origem_lat))
              )
          ) AS distance
          FROM "Caronas"
      ) AS subquery
      ORDER BY distance ASC;
      `,
      {
        replacements: { latitude, longitude, radioKm },
        model: Carona,
        mapToModel: true,
      }
    );

    return caronas || [];
  },
};

export default CaronaService;
