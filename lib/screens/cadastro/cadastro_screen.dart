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

/// Cadastro do agente: formulário completo com validação campo a campo
/// e aceite da LGPD. Cobre o requisito de formulário + validação.
///
/// Guarda o mínimo (apelido e faixa etária), seguindo a LGPD para um
/// público adolescente — sem nome completo, CPF ou data de nascimento.
class CadastroScreen extends Tela {
  const CadastroScreen();

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    Cabecalho.exibir('Criar conta de agente');
    stdout.writeln(
        '  ${Ansi.textoSecundario}Preencha os dados abaixo.${Ansi.reset}\n');

    final apelido = FormTerminal.lerValidado('Apelido', Validadores.apelido);
    final email = FormTerminal.lerValidado('E-mail', Validadores.email);
    final senha = FormTerminal.lerValidado('Senha', Validadores.senha);
    FormTerminal.lerValidado(
      'Confirmar senha',
      (v) => Validadores.confirmarSenha(v, senha),
    );

    stdout.writeln();
    final perfilTexto = FormTerminal.escolher('Perfil', ['Aluno', 'Professor']);
    final faixa = FormTerminal.escolher(
      'Faixa etária',
      ['Até 13', '14 a 17', '18 a 24', '25 ou mais'],
    );

    stdout.writeln();
    final aceitou = FormTerminal.confirmar(
      'Aceito os termos e a política de privacidade',
    );
    final erroAceite = Validadores.aceiteTermos(aceitou);
    if (erroAceite != null) {
      stdout.writeln();
      FormTerminal.aviso(erroAceite, cor: Ansi.alerta);
      Terminal.ler('\n  ${Ansi.tenue}ENTER para voltar${Ansi.reset} ');
      nav.pop();
      return;
    }

    stdout.writeln();
    await Terminal.barraProgresso('Criando conta',
        cor: Ansi.ciano, duracaoMs: 900);

    final perfil = perfilTexto == 'Professor'
        ? PerfilUsuario.professor
        : PerfilUsuario.jogador;
    Sessao.instancia.entrar(Usuario(
      apelido: apelido,
      email: email,
      perfil: perfil,
      faixaEtaria: faixa,
    ));

    stdout.writeln();
    FormTerminal.aviso(
        'Conta criada! Bem-vindo à resistência, agente $apelido.');
    Terminal.ler(
        '\n  ${Ansi.tenue}ENTER para abrir o Mapa da Cidade${Ansi.reset} ');

    nav.pushReplacement(Rotas.mapa);
  }
}
