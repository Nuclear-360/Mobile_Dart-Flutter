import 'package:nuclear_360/app.dart';

/// Execute com `dart run` (ou `dart run bin/main.dart --sem-intro`).
Future<void> main(List<String> args) async {
  final app = Nuclear360App(pularIntro: args.contains('--sem-intro'));
  await app.executar();
}
