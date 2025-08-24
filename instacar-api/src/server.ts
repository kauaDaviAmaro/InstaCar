import dotenv from 'dotenv';
dotenv.config();

import app from './app';
import './models/User';
import { syncDatabase } from './config/db';
import { setupSwagger } from './config/swagger';

const PORT = process.env.PORT || 5000;

syncDatabase();
setupSwagger(app);

app.listen(PORT, () => {
  console.log(`Server running in http://localhost:${PORT}`);
});
