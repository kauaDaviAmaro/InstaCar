export const MESSAGES = {
  USER: {
    SUCCESS: 'Usuário cadastrado com sucesso!',
    ERROR: 'Erro ao cadastrar usuário',
    INVALID_USER: 'Usuário incompleto',
    NOT_FOUND: 'Usuário não encontrado',
  },
  AUTH: {
    INVALID_CREDENTIALS: 'Credenciais inválidas',
    LOGIN_SUCCESS: 'Login realizado com sucesso',
    NO_TOKEN: 'Token não fornecido',
    INVALID_TOKEN: 'Token inválido',
    RESET_CODE_SUCCESS: 'Código válido. Pode redefinir a senha.',
    RESET_PASSWORD_SUCCESS: 'Senha redefinida com sucesso'
  },
  GENERAL: {
    SERVER_ERROR: 'Erro interno do servidor',
    UNAUTHORIZED: 'Acesso não autorizado',
  },
  EMAIL: {
    SUBJECT: 'Código de Recuperação',
    SUCCESS: 'Código enviado para o e-mail.'
  }
};
