import { Sequelize } from 'sequelize';

// Check if DATABASE_URL is provided, otherwise use fallback configuration
const databaseUrl = process.env.DATABASE_URL;

if (!databaseUrl) {
  console.warn('DATABASE_URL environment variable is not set. Using fallback configuration.');
}

// Create a connection without specifying the database first
const sequelizeWithoutDB = new Sequelize({
  dialect: 'mysql',
  logging: false,
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '3306'),
  username: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'password',
  retry: {
    max: 3,
    timeout: 5000,
  },
});

// Create the main sequelize instance with the database
const sequelize = new Sequelize({
  dialect: 'mysql',
  logging: false,
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '3306'),
  username: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'password',
  database: process.env.DB_NAME || 'instacar',
  retry: {
    max: 3,
    timeout: 5000,
  },
});

export const initializeDatabase = async () => {
  try {
    console.log('Attempting to connect to MySQL server...');
    
    // First, connect without database to create it if it doesn't exist
    await sequelizeWithoutDB.authenticate();
    console.log('✅ MySQL server connected successfully!');
    
    // Create database if it doesn't exist
    const dbName = process.env.DB_NAME || 'instacar';
    console.log(`Creating database '${dbName}' if it doesn't exist...`);
    await sequelizeWithoutDB.query(`CREATE DATABASE IF NOT EXISTS \`${dbName}\``);
    console.log(`✅ Database '${dbName}' is ready!`);
    
    // Close the connection without database
    await sequelizeWithoutDB.close();
    
    // Now connect to the specific database
    console.log('Connecting to the specific database...');
    await sequelize.authenticate();
    console.log('✅ Database connected successfully!');
    
    // Import all models here to avoid circular dependencies
    const User = require('../models/User').default;
    const Conversation = require('../models/conversation.model').default;
    const Message = require('../models/message.model').default;
    const Carona = require('../models/carona').default;
    const Feedback = require('../models/feedback.model').default;
    
    // Set up associations
    Conversation.hasMany(Message, { foreignKey: 'conversationId' });
    Message.belongsTo(Conversation, { foreignKey: 'conversationId' });
    
    // Sync all models
    console.log('Synchronizing database models...');
    await User.sync({ alter: true });
    await Conversation.sync({ alter: true });
    await Message.sync({ alter: true });
    await Carona.sync({ alter: true });
    await Feedback.sync({ alter: true });
    
    console.log('✅ Database synchronized successfully!');
    console.log('🎉 Database initialization completed!');
  } catch (error) {
    console.error('❌ Error in database initialization:', error);
    
    // Provide helpful error messages for common issues
    if (error && typeof error === 'object' && 'code' in error) {
      const dbError = error as { code: string };
      if (dbError.code === 'ECONNREFUSED') {
        console.error('💡 Make sure MySQL server is running on the specified host and port.');
      } else if (dbError.code === 'ER_ACCESS_DENIED_ERROR') {
        console.error('💡 Check your MySQL username and password.');
      } else if (dbError.code === 'ENOTFOUND') {
        console.error('💡 Check your MySQL host configuration.');
      }
    }
    
    throw error; // Re-throw to handle the error in the calling code
  }
};

export default sequelize;
