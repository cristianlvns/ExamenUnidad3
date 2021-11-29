import 'dart:convert';

import 'package:examen_unidad_3/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestResult {
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

class UsuarioService with ChangeNotifier {
  final host = 'http://127.0.0.1:3002';

  Future<RequestResult> mostrarUsuarios() async {
    final uri = Uri.parse(host + '/users');
    final resp = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final lista = json.decode(resp.body) as List<dynamic>;
    final data = lista.map((e) => Usuario.fromJson(e)).toList();
    return RequestResult(true, data);
  }

  Future<RequestResult> nuevoUsuario(Usuario usuario) async {
    final data = {'nombre': usuario.nombre, 'apellido': usuario.apellido};
    final uri = Uri.parse(host + '/users');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (resp.statusCode == 201) {
      final response = resp.body;
      return RequestResult(true, response);
    } else {
      return RequestResult(false, null);
    }
  }
}
