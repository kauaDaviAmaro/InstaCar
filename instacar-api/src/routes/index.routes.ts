import express from 'express';
import fs from 'fs';
import path from 'path';

const router = express.Router();

const routesPath = __dirname;

fs.readdirSync(routesPath).forEach((file) => {
  if (file !== 'index.routes.ts' && file.endsWith('.routes.ts')) {
    const route = require(path.join(routesPath, file));
    if (route.default) {
      const routePath = `/${file.replace('.routes.ts', '')}`;
      router.use(routePath, route.default);
    }
  }
});

export default router;