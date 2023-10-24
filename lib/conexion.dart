import 'dart:convert';

import 'package:http/http.dart' as http;


abstract class Conexion {

static Future<List<dynamic>?>? data(params) async {
    final response = await http.get(Uri.parse('http://localhost/hotel_reserva/conexionphp/hoteles_reserva.php'+params));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      return data;
    } else {
      
      return [];
    }
  }

  
}