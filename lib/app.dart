import 'core/navigation/navegador.dart';
import 'core/navigation/rotas.dart';
import 'core/terminal/terminal.dart';
import 'screens/em_construcao/em_construcao_screen.dart';
import 'screens/inicio/inicio_screen.dart';
import 'screens/sobre/sobre_screen.dart';
import 'screens/splash/splash_screen.dart';

/// Ponto central do app: registra as rotas e inicia a navegação.
/// Equivale ao `MaterialApp` no Flutter.
class Nuclear360App {
  Nuclear360App({this.pularIntro = false});

  final bool pularIntro;

  late final Navegador navegador = Navegador({
    Rotas.splash: () => const SplashScreen(),
    Rotas.inicio: () => InicioScreen(),
    Rotas.sobre: () => const SobreScreen(),
    Rotas.login: () => const EmConstrucaoScreen(
          titulo: 'Login',
          descricao: 'Entrada do agente com e-mail e senha.',
        ),
    Rotas.cadastro: () => const EmConstrucaoScreen(
          titulo: 'Criar conta de agente',
          descricao: 'Formulário com apelido, e-mail, senha e aceite LGPD.',
        ),
  });

  Future<void> executar() async {
    try {
      await navegador.iniciar(Rotas.splash, argumentos: pularIntro);
    } finally {
      Terminal.restaurar();
    }
  }
}
