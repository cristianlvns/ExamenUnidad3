import 'package:examen_unidad_3/models/usuario.dart';
import 'package:examen_unidad_3/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  //List<Usuario> renglonesUsuario = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: FutureBuilder(
        future: cargarUsuarios(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('Error: ${data.error}'));
          } else if (data.hasData) {
            var renglonesUsuario = data.data as List<Usuario>;
            return DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Apellido')),
              ],
              rows: List.generate(
                renglonesUsuario.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(renglonesUsuario[index].id.toString())),
                    DataCell(Text(renglonesUsuario[index].nombre!)),
                    DataCell(Text(renglonesUsuario[index].apellido!)),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Cargando...'));
          }
        },
      ),
    );
  }

  Future<List<Usuario>> cargarUsuarios() async {
    final usuarioService = UsuarioService();
    final listaUsuarios = await usuarioService.mostrarUsuarios();
    final renglonesUsuario = listaUsuarios.data;
    return renglonesUsuario;
  }
}
