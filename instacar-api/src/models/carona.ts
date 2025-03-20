import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/db';
import { ICarona, Point } from '../types';

class Carona extends Model <ICarona> implements ICarona {
    id?: string;
    pontoInicio?: Point;
    pontoFinal?: Point;
    observacao?: string;
    userId?: string;
}

Carona.init(
    {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true,
        },
        pontoInicio: {
            type: DataTypes.GEOGRAPHY('POINT', 4326),
            allowNull: false,
        },
        pontoFinal: {
            type: DataTypes.GEOGRAPHY('POINT', 4326),
            allowNull: false,
        },
        observacao: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        userId: {
            type: DataTypes.UUID,
            allowNull: false,
        },
    },
    {
        sequelize,
        modelName: 'Carona',
        timestamps: true,
    }
);

export default Carona;