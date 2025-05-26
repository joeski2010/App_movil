import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar JSON

// ...

Future<Map<String, dynamic>> fetchCiudadano(String dni) async {
  final response = await http.get(
    Uri.parse('http://190.187.182.56:8081/api/Ciudadano/$dni'),
  );

  if (response.statusCode == 200) {
    // Si la petición es exitosa, parsea el JSON
    return json.decode(response.body);
  } else {
    // Si la petición falla, lanza un error
    throw Exception('Error al cargar los datos del ciudadano');
  }
}