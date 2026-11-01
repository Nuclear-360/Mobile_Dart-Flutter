import 'core/navigation/navegador.dart';
import 'core/navigation/rotas.dart';
import 'core/terminal/terminal.dart';
import 'screens/cadastro/cadastro_screen.dart';
import 'screens/distrito/distrito_screen.dart';
import 'screens/inicio/inicio_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/mapa/mapa_screen.dart';
import 'screens/medidor/medidor_screen.dart';
import 'screens/perfil/perfil_screen.dart';
import 'screens/quiz/quiz_screen.dart';
import 'screens/resultado/resultado_screen.dart';
import 'screens/sobre/sobre_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/verdade_radioativo/verdade_radioativo_screen.dart';

/// Ponto central do app: registra as rotas e inicia a navegação.
/// Equivale ao `MaterialApp` no Flutter.
class Nuclear360App {
  Nuclear360App({this.pularIntro = false});

  final bool pularIntro;

  late final Navegador navegador = Navegador({
    Rotas.splash: () => const SplashScreen(),
    Rotas.inicio: () => InicioScreen(),
    Rotas.login: () => const LoginScreen(),
    Rotas.cadastro: () => const CadastroScreen(),
    Rotas.mapa: () => MapaScreen(),
    Rotas.distrito: () => DistritoScreen(),
    Rotas.quiz: () => QuizScreen(),
    Rotas.verdadeOuRadioativo: () => VerdadeRadioativoScreen(),
    Rotas.resultado: () => const ResultadoScreen(),
    Rotas.medidorBananas: () => MedidorScreen(),
    Rotas.perfil: () => const PerfilScreen(),
    Rotas.sobre: () => const SobreScreen(),
  });

  Future<void> executar() async {
    try {
      await navegador.iniciar(Rotas.splash, argumentos: pularIntro);
    } finally {
      Terminal.restaurar();
    }
  }
}
