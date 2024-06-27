import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/config.dart';
import 'controles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int victoriasCruz = 0;
  int victoriasCirculo = 0;

  int contador = 0;
  estados inicial = estados.cruz;

  void actualizarContadores(estados ganador) {
    setState(() {
      if (ganador == estados.cruz) {
        victoriasCruz++;
      } else if (ganador == estados.circulo) {
        victoriasCirculo++;
      }
    });
  }

  void mostrarDialogoReiniciar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reiniciar el juego'),
          content: const Text('¿Deseas reiniciar el juego?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                reiniciarJuego();
              },
              child: const Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void mostrarDialogoSalir(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Salir del juego'),
          content: const Text('¿Estás seguro de que deseas salir del juego?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: const Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void reiniciarJuego() {
    setState(() {
      tablero = List.filled(9, estados.vacio);
      contador = 0;
      inicial = estados.cruz;
      victoriasCruz = 0;
      victoriasCirculo = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gato'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Reiniciar') {
                mostrarDialogoReiniciar(context);
              } else if (value == 'Salir') {
                mostrarDialogoSalir(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Reiniciar', 'Salir'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Victorias Cruz: $victoriasCruz'),
                  Text('Victorias Circulo: $victoriasCirculo'),
                ],
              ),
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      Image.asset("imagenes/board.png"),
                      Controles(
                        actualizarContadores: actualizarContadores,
                        inicial: inicial,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
