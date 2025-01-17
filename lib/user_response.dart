import 'color_data.dart';
import 'dart:io';

String userResponse() {
  String response = stdin.readLineSync().toString();
  try {
    if (response.contains("sair")) {
      ColoredMensage.paint(mensage: "ADEUUUSSS", isDestaque: true);
      exit(0);
    } else if (response.isEmpty) {
      ColoredMensage.paint(mensage: "Digite algo", isDestaque: true);
      return userResponse(); // Chama novamente para permitir uma nova tentativa
    }
  } catch (e) {
    ColoredMensage.paint(mensage: e.toString(), isError: true);
  }
  return response;
}
