import 'package:examen_unidad_3/screens/nuevo_usuario_screen.dart';
import 'package:examen_unidad_3/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioService()),
      ],
      child: MaterialApp(
        title: 'Usuarios',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const NuevoUsuarioScreen(),
      ),
    );
  }
}
