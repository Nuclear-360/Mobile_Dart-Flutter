import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/rotas.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../models/enums.dart';
import '../../models/usuario.dart';
import '../../state/sessao.dart';
import '../../validators/validadores.dart';
import '../../widgets/cabecalho.dart';
import '../../widgets/form_terminal.dart';

/// Login do agente: formulário simples com e-mail e senha.
/// Nesta sprint a autenticação é mockada (qualquer dado válido entra).
class LoginScreen extends Tela {
  const LoginScreen();

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    Cabecalho.exibir('Login');
    stdout.writeln(
        '  ${Ansi.textoSecundario}Acesse para iniciar a missão.${Ansi.reset}\n');

    final email =
        FormTerminal.lerValidado('E-mail', (v) => Validadores.email(v));
    FormTerminal.lerValidado(
      'Senha',
      (v) => v.isEmpty ? 'Informe a senha.' : null,
    );

    stdout.writeln();
    await Terminal.barraProgresso('Autenticando',
        cor: Ansi.ciano, duracaoMs: 800);

    final apelido = email.split('@').first;
    Sessao.instancia.entrar(Usuario(
      apelido: apelido,
      email: email,
      perfil: PerfilUsuario.jogador,
      faixaEtaria: '—',
    ));

    stdout.writeln();
    FormTerminal.aviso('Bem-vindo, agente $apelido! Acesso liberado.');
    Terminal.ler(
        '\n  ${Ansi.tenue}ENTER para abrir o Mapa da Cidade${Ansi.reset} ');

    nav.pushReplacement(Rotas.mapa);
  }
}
