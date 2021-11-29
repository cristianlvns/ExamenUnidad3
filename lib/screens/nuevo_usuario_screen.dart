import 'package:examen_unidad_3/models/usuario.dart';
import 'package:examen_unidad_3/screens/users_screen.dart';
import 'package:examen_unidad_3/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NuevoUsuarioScreen extends StatelessWidget {
  const NuevoUsuarioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nombreCtrl = TextEditingController();
    final apellidoCtrl = TextEditingController();
    final usuarioService = Provider.of<UsuarioService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: apellidoCtrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.family_restroom),
                labelText: 'Apellido',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Crear Nuevo Usuario',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () async {
                var usuario = Usuario(
                  nombre: nombreCtrl.text,
                  apellido: apellidoCtrl.text,
                );
                var resultUsuario = await usuarioService.nuevoUsuario(usuario);
                if (resultUsuario.ok) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Mensaje'),
                      content: Text(resultUsuario.data.toString()),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => UsersScreen()),
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('No se pudo conectar al servidor'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {},
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
