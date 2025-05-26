import { Sequelize } from 'sequelize';
import User from '../models/User'; // Ensure the User model is imported

const sequelize = new Sequelize(process.env.DATABASE_URL as string, {
  dialect: 'mysql',
  logging: false,
});

(async () => {
  try {
    await sequelize.authenticate();
    console.log('Database connect!');
  } catch (error) {
    console.error('Database error connect:', error);
  }
})();

export const syncDatabase = async () => {
  try {
    await User.sync({ alter: true });
    await sequelize.sync({ alter: true });
    console.log('Database synchronized!');
  } catch (error) {
    console.error('Error in sync:', error);
  }
};

export default sequelize;
