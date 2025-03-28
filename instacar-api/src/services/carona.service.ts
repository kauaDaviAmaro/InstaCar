import Carona from "../models/carona";
import { ICaronaDTO } from "../types";

const CaronaService = {
  async getAllCaronas() {
    const caronas = await Carona.findAll();
    return caronas;
  },

  async createCarona(caronaData: ICaronaDTO) {
    //TODO: Validate the carona data here if necessary

    const carona = await Carona.create(caronaData);
    return carona;
  },
};

export default CaronaService;
