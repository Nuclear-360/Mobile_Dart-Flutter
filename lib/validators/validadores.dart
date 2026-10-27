/// Validações do formulário de cadastro.
///
/// Cada função devolve `null` quando o valor é válido ou a mensagem de
/// erro, exatamente o formato do `validator` do `TextFormField` no Flutter.
abstract final class Validadores {
  static final RegExp _apelido = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
  static final RegExp _letra = RegExp(r'[A-Za-z]');
  static final RegExp _numero = RegExp(r'\d');

  static String? apelido(String? valor) {
    final v = valor?.trim() ?? '';
    if (v.isEmpty) return 'Informe um apelido.';
    if (!_apelido.hasMatch(v)) {
      return 'Use de 3 a 20 letras, números ou _ (sem espaços).';
    }
    return null;
  }

  static String? email(String? valor) {
    final v = valor?.trim() ?? '';
    if (v.isEmpty) return 'Informe um e-mail.';
    if (!_email.hasMatch(v)) return 'E-mail inválido.';
    return null;
  }

  static String? senha(String? valor) {
    final v = valor ?? '';
    if (v.isEmpty) return 'Informe uma senha.';
    if (v.length < 8) return 'A senha precisa ter pelo menos 8 caracteres.';
    if (!_letra.hasMatch(v) || !_numero.hasMatch(v)) {
      return 'A senha precisa ter letras e números.';
    }
    return null;
  }

  static String? confirmarSenha(String? valor, String senha) {
    if ((valor ?? '').isEmpty) return 'Confirme a senha.';
    if (valor != senha) return 'As senhas não conferem.';
    return null;
  }

  static String? aceiteTermos(bool aceitou) =>
      aceitou ? null : 'É preciso aceitar os termos e a política de privacidade.';
}
