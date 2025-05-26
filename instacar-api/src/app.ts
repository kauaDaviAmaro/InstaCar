import express from "express";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import routes from "./routes/index.routes";
import { Socket } from "dgram";
import { Server } from "socket.io";
import http from "http";
import Conversation from "./models/conversation.model";
import Message from "./models/message.model";
import { sendMessage } from "./controllers/chat.controller";

const app = express();

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});

const users: { [userId: string]: string } = {};

io.on("connection", (socket) => {
  const userId = socket.handshake.query.userId as string;
  users[userId] = socket.id;

  console.log(`Usuário conectado: ${userId} (${socket.id})`);


  socket.on("sendMessage", async ({ senderId, receiverId, message }) => {
    const savedMessage = await sendMessage(senderId, receiverId, message);
    const receiverSocketId = users[receiverId];

    if (receiverSocketId) {
      io.to(receiverSocketId).emit("receiveMessage", savedMessage);
    }
  });

  socket.on("disconnect", () => {
    delete users[userId];
    console.log(`Usuário desconectado: ${userId}`);
  });
});


app.use(express.json());
app.use(cors());
app.use(helmet());
app.use(morgan("dev"));

app.use("/api", routes);


Conversation.hasMany(Message, { foreignKey: 'conversationId' });
Message.belongsTo(Conversation, { foreignKey: 'conversationId' });

export default app;
