import express from "express";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import routes from "./routes/index.routes";
import { Socket } from "dgram";
import { Server } from "socket.io";
import http from "http";

const app = express();

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});

io.on("connection", (socket) => {
  console.log(`Usuário conectado: ${socket.id}`);

  // Evento para entrar em uma sala (baseado no ID da carona)
  socket.on("joinRoom", (caronaId) => {
    socket.join(caronaId);
    console.log(`Usuário ${socket.id} entrou na sala: ${caronaId}`);
  });

  // Evento para enviar mensagens
  socket.on("sendMessage", ({ caronaId, userId, message }) => {
    const chatMessage = {
      userId,
      message,
      timestamp: new Date(),
    };

    // Enviar mensagem para todos na sala da carona
    io.to(caronaId).emit("receiveMessage", chatMessage);
  });

  socket.on("disconnect", () => {
    console.log(`Usuário desconectado: ${socket.id}`);
  });
});

app.use(express.json());
app.use(cors());
app.use(helmet());
app.use(morgan("dev"));

app.use("/api", routes);

export default app;
