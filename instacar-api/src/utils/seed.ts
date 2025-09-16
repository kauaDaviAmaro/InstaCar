import bcrypt from 'bcryptjs';
import User from '../models/User';
import Carona from '../models/carona';
import Conversation from '../models/conversation.model';
import Message from '../models/message.model';

export const autoSeed = async () => {
  if (process.env.SEED_DISABLED === 'true') {
    return;
  }

  const userCount = await User.count();
  if (userCount > 0) {
    console.log('Database already seeded!');
    return; // already seeded
  }

  const password = await bcrypt.hash('123456', 10);

  // Create multiple users (drivers and riders)
  const [alice, bob, carlos, diana, eva, _fernando, giulia] = await Promise.all([
    User.create({
      name: 'Alice Driver',
      email: 'alice@example.com',
      password,
      gender: 'F',
      tipoVeiculo: 'Carro',
      modeloVeiculo: 'Fiat Argo',
      corVeiculo: 'Prata',
      placa: 'ABC1D23',
      phone: '11999990001',
    }),
    User.create({
      name: 'Bob Rider',  
      email: 'bob@example.com',
      password,
      gender: 'M',
      phone: '11999990002',
    }),
    User.create({
      name: 'Carlos Motorista',
      email: 'carlos@example.com',
      password,
      gender: 'M',
      tipoVeiculo: 'Carro',
      modeloVeiculo: 'Onix',
      corVeiculo: 'Preto',
      placa: 'CAR0L05',
      phone: '11999990003',
    }),
    User.create({
      name: 'Diana Passageira',
      email: 'diana@example.com',
      password,
      gender: 'F',
      phone: '11999990004',
    }),
    User.create({
      name: 'Eva Driver',
      email: 'eva@example.com',
      password,
      gender: 'F',
      tipoVeiculo: 'Moto',
      modeloVeiculo: 'CG 160',
      corVeiculo: 'Vermelha',
      placa: 'EVA1A23',
      phone: '11999990005',
    }),
    User.create({
      name: 'Fernando',
      email: 'fernando@example.com',
      password,
      gender: 'M',
      phone: '11999990006',
    }),
    User.create({
      name: 'Giulia',
      email: 'giulia@example.com',
      password,
      gender: 'F',
      phone: '11999990007',
    }),
  ]);

  // Create multiple caronas across times and routes
  const now = Date.now();
  await Carona.bulkCreate([
    {
      motoristaId: alice.id as string,
      origem: 'Av. Paulista, 1000',
      destino: 'USP - Butantã',
      dataHora: new Date(now + 1 * 3600_000).toISOString(),
      vagas: 3,
      status: 'disponível',
      origem_lat: -23.561684,
      origem_lon: -46.655981,
      destino_lat: -23.561399,
      destino_lon: -46.730789,
      observacao: 'Saindo às 18h, pontual.',
      vagasDisponiveis: 3,
    },
    {
      motoristaId: carlos.id as string,
      origem: 'Terminal Tietê',
      destino: 'Centro de Osasco',
      dataHora: new Date(now + 2 * 3600_000).toISOString(),
      vagas: 2,
      status: 'disponível',
      origem_lat: -23.511406,
      origem_lon: -46.612025,
      destino_lat: -23.532903,
      destino_lon: -46.791397,
      observacao: 'Paro no caminho se precisar.',
      vagasDisponiveis: 2,
    },
    {
      motoristaId: alice.id as string,
      origem: 'Pinheiros',
      destino: 'Moema',
      dataHora: new Date(now + 3 * 3600_000).toISOString(),
      vagas: 1,
      status: 'disponível',
      observacao: 'Somente 1 vaga.',
      vagasDisponiveis: 1,
    },
    {
      motoristaId: eva.id as string,
      origem: 'Brooklin',
      destino: 'Vila Olímpia',
      dataHora: new Date(now + 45 * 60_000).toISOString(),
      vagas: 1,
      status: 'disponível',
      observacao: 'Trajeto rápido de moto.',
      vagasDisponiveis: 1,
    },
    {
      motoristaId: carlos.id as string,
      origem: 'São Caetano do Sul',
      destino: 'Paulista',
      dataHora: new Date(now + 6 * 3600_000).toISOString(),
      vagas: 4,
      status: 'disponível',
      observacao: 'Saída de manhã cedo.',
      vagasDisponiveis: 4,
    },
    {
      motoristaId: alice.id as string,
      origem: 'Lapa',
      destino: 'Berrini',
      dataHora: new Date(now + 90 * 60_000).toISOString(),
      vagas: 2,
      status: 'disponível',
      observacao: 'Sem ar-condicionado hoje.',
      vagasDisponiveis: 2,
    },
  ]);

  // Create conversations with messages
  const conv1 = await Conversation.create({ user1Id: alice.id as string, user2Id: bob.id as string });
  const conv2 = await Conversation.create({ user1Id: carlos.id as string, user2Id: diana.id as string });
  const conv3 = await Conversation.create({ user1Id: eva.id as string, user2Id: giulia.id as string });

  await Message.bulkCreate([
    { conversationId: (conv1 as any).id, senderId: alice.id as string, message: 'Oi! Posso te levar hoje.' },
    { conversationId: (conv1 as any).id, senderId: bob.id as string, message: 'Perfeito! Que horas você passa?' },
    { conversationId: (conv1 as any).id, senderId: alice.id as string, message: 'Saio às 18h da Paulista.' },

    { conversationId: (conv2 as any).id, senderId: diana.id as string, message: 'Olá Carlos, tem vaga às 7h?' },
    { conversationId: (conv2 as any).id, senderId: carlos.id as string, message: 'Tenho sim, ponto de encontro no Tietê.' },

    { conversationId: (conv3 as any).id, senderId: giulia.id as string, message: 'Oi Eva, consegue me levar até a Vila Olímpia?' },
    { conversationId: (conv3 as any).id, senderId: eva.id as string, message: 'Consigo sim, saio em 45 minutos.' },
  ]);

  console.log('Database seeded successfully with more sample data!');
};

export default autoSeed;


