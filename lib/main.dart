import 'package:calcular_multa/data.dart';
import 'package:calcular_multa/user_response.dart';
import 'package:calcular_multa/color_data.dart';
import 'dart:io';

void main() {
  MapDeserializer caculate = MapDeserializer();

  Map<String, dynamic> context = {};
  caculate.init(context);
}

class MapDeserializer {
  Map<String, dynamic> context = {};
  Map<String, dynamic> data = database;

  void init(Map<String, dynamic> context) {
    calculate(context);
  }

  void calculate(Map<String, dynamic> context) async {
    Map<String, dynamic> dataValueToMap = valuesToMap(context);
    int valueOne = dataValueToMap["body"]["value one"];
    int valueTwo = dataValueToMap["body"]["value two"];

    ColoredMensage.paint(
        mensage: "Valor mínimo: ${valueOne * database["Ufir"]}R\$", isResponse: true);
    ColoredMensage.paint(
        mensage: "Valor máximo: ${valueTwo * database["Ufir"]}R\$", isResponse: true);

    await Future.delayed(Duration(seconds: 2));
    ColoredMensage.paint(mensage: "Encerrando programa", isDestaque: true);

    exit(0);
  }

  Map<String, dynamic> valuesToMap(Map<String, dynamic> context) {
    Map<String, dynamic> dataValuesToMap = degreeToMap(context)["body"];
    Map<String, dynamic> returnDataValuesToMap = {};
    String howMuch = "";

    while (returnDataValuesToMap.isEmpty) {
      try {
        if (!context.containsKey("Values")) {
          ColoredMensage.paint(
              mensage: "Digite a quantidade de pessoas", isAsk: true);
          int? response = int.tryParse(userResponse());

          if (response == null || response <= 0) {
            ColoredMensage.paint(
                mensage: "Por favor, insira um valor válido", isError: true);
          } else {
            if (response <= 10) {
              howMuch = "01-10";
            } else if (response <= 25) {
              howMuch = "11-25";
            } else if (response <= 50) {
              howMuch = "26-50";
            } else if (response <= 100) {
              howMuch = "51-100";
            } else if (response <= 250) {
              howMuch = "101-250";
            } else if (response <= 500) {
              howMuch = "251-500";
            } else if (response <= 1000) {
              howMuch = "501-1000";
            } else {
              howMuch = ">1000";
            }
            context["Values"] = howMuch;
            returnDataValuesToMap["body"] = dataValuesToMap[howMuch];
          }
        } else {
          returnDataValuesToMap["body"] = dataValuesToMap[context["Values"]];
        }
      } catch (e) {
        ColoredMensage.paint(mensage: e.toString(), isError: true);
      }
    }

    return returnDataValuesToMap;
  }

  Map<String, dynamic> degreeToMap(Map<String, dynamic> context) {
    Map<String, dynamic> data = typeToMap(context)["body"]["Grau"];

    Map<String, dynamic> returnDegreeDataMap = {};

    while (returnDegreeDataMap.isEmpty) {
      try {
        if (!context.containsKey("Grau")) {
          ColoredMensage.paint(
              mensage: "Digite o grau da infração:\nObs: O Grau tem 4 níveis",
              isAsk: true);

          stdout.write(ColoredMensage.penPink("Grau>>>> "));
          int? response = int.tryParse(userResponse());
          if (response == null || response.isNaN) {
            ColoredMensage.paint(mensage: "Resposta inválida", isError: true);
            return degreeToMap(context);
          } else if (response < 1 || response > 4) {
            ColoredMensage.paint(mensage: "Resposta inválida", isError: true);
            return degreeToMap(context);
          } else {
            returnDegreeDataMap = {"body": data[response.toString()]};
            context['Grau'] = response;
          }
        } else if (context.containsKey("Grau")) {
          returnDegreeDataMap["body"] = data[context["Grau"]];
        }
      } catch (e) {
        ColoredMensage.paint(mensage: e.toString(), isError: true);
      }
    }

    return returnDegreeDataMap;
  }

//Filtrando por tipo
  Map<String, dynamic> typeToMap(Map<String, dynamic> context) {
    Map<String, dynamic> returnDataMapType = {};
    while (returnDataMapType.isEmpty) {
      try {
        data = database["Type"];
        if (context.isNotEmpty && context.containsKey("Type")) {
          returnDataMapType["body"] = data[context["Type"]];
          return returnDataMapType;
        } else {
          ColoredMensage.paint(
              mensage: "Categoria:\n1)Medicina\n2)Safety\n\n", isAsk: true);

          stdout.write(ColoredMensage.penPink("Categoria>>>>  "));
          String? response = userResponse();

          if (response == "Medicina") {
            returnDataMapType = {"body": data["Medicina"]};
            context.addAll({"Type": response});
          } else if (response == "Safety") {
            returnDataMapType = {"body": data["Safety"]};
            context.addAll({"Type": response});
          } else {
            ColoredMensage.paint(
                mensage: "Por favor, coloque uma das duas opções",
                isError: true);

            context.clear();
            // Chama novamente para permitir uma nova tentativa
            return typeToMap(context);
          }
        }
      } catch (e) {
        ColoredMensage.paint(mensage: e.toString(), isError: true);
      }
    }

    return returnDataMapType;
  }
}
