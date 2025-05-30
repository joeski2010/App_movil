import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ciudadano.dart';

class CiudadanoService {
  static Future<Ciudadano> fetchCiudadano(String dni) async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost:7178/api/Ciudadano/$dni'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Ciudadano.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al cargar los datos del ciudadano: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al cargar los datos del ciudadano: $e');
    }
  }

  static Future validarCiudadano({
    required int idTipoDocumento,
    required String nvNumeroDocumento,
    required String fechaEmision,
  }) async {
    const String url = 'https://localhost:7178/api/ciudadano/validar';

    print("Fucnion");
    print(idTipoDocumento);
    print(nvNumeroDocumento);
    print(fechaEmision);
    print(jsonEncode({
          'idTipoDocumento': idTipoDocumento,
          'nvNumeroDocumento': nvNumeroDocumento,
          'fechaEmision': fechaEmision,
        }));
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'idTipoDocumento': idTipoDocumento,
          'nvNumeroDocumento': nvNumeroDocumento,
          'fechaEmision': fechaEmision,
        }),
      );

      if (response.statusCode == 200) {
        print("servicio");
        print(json.decode(response.body)['data']['existe']);
        return json.decode(response.body)['data']['existe'];
      } else {
        throw Exception('Error al validar ciudadanos: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al validar ciudadan: $e');
    }
  }
}