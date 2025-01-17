import 'package:ansicolor/ansicolor.dart';

class ColoredMensage {
  static AnsiPen penYellow = AnsiPen()..yellow();
  static AnsiPen penPink = AnsiPen()..rgb(r: 1.0, g: 0.41, b: 0.71);
  static AnsiPen penGreen = AnsiPen()..green();
  static AnsiPen penBlue = AnsiPen()..blue();
  static AnsiPen penRed = AnsiPen()..red();
  static AnsiPen penDefault = AnsiPen()..white();

  static void paint({
    required String mensage,
    bool? isError,
    bool? isDestaque,
    bool? isResponse,
    bool? isContext,
    bool? isAsk,
    bool? isDefault,
  }) {
    if (mensage.isNotEmpty) {
      if (isError == true) {
        print(penRed(mensage));
      } else if (isDestaque == true) {
        print(penPink(mensage));
      } else if (isResponse == true) {
        print(penBlue(mensage));
      } else if (isContext == true) {
        print(penYellow(mensage));
      } else if (isAsk == true) {
        print(penGreen(mensage));
      } else {
        print(penDefault(mensage));
      }
    }
  }
}
