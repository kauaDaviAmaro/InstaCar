import Carona from "../models/carona";

export const getAllCaronas = async () => {
  const caronas = await Carona.findAll();

  return caronas;
};
