import { Sequelize } from 'sequelize';
import User from '../models/User'; // Ensure the User model is imported

const sequelize = new Sequelize(process.env.DATABASE_URL as string, {
  dialect: 'postgres',
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
    await User.sync({ force: true }); // Sync the User table first
    await sequelize.sync({ force: true });
    console.log('Database synchronized!');
  } catch (error) {
    console.error('Error in sync:', error);
  }
};

export default sequelize;
