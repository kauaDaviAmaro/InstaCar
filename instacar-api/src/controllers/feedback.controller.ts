import { Request, Response } from 'express';
import Feedback from '../models/feedback.model';

export const submitFeedback = async (req: Request, res: Response): Promise<void> => {
    const { name, email, rating, comment } = req.body;

    if (!name || !email || !rating) {
        res.status(400).json({ error: 'Campos obrigatórios não preenchidos' });
        return;
    }
    
    try {
        await Feedback.create({ name, email, rating, comment });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao salvar feedback no banco de dados' });
        return;
    }

    res.status(200).json({ message: 'Feedback enviado com sucesso' });
};