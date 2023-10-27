import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/config/utils/my_colors.dart';
import 'package:flutter_application_prgrado/presentation/widgets/side_menu/side_menu.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      drawer: const NavigatorDrawer(),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Color.fromARGB(255, 241, 241, 241),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Image.asset('assets/images/prototype2.png'),
                width: 150,
                height: 150,
              ),
            ),
            _contaier(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Center(
                          child: Text(
                    "Conectado",
                    style: TextStyle(fontSize: 17),
                  ))),
                  Expanded(
                      child: Center(
                          child: Column(
                    children: [
                      Text(
                        "Excelente",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "Conexión",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ))),
                  Expanded(
                    child: Lottie.asset(
                      'assets/lottie/animation_lo7s44ih.json', // Ruta a tu archivo JSON de animación
                      width: 50, // Ajusta el ancho según tus preferencias
                      height: 50, // Ajusta la altura según tus preferencias
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _contaier(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "30,7",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " c°",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          Text(
                            "Temperatura dispositivo",
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "03:00",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " hrs",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          Text(
                            "Tiempo de actividad",
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _contaier(
                    InkWell(
                      onTap: (() {
                        Navigator.pushNamed(context, Routes.cameraManagment);
                      }),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Camaras conectadas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "2",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.cameraswitch_sharp,
                            color: Colors.blueAccent,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _contaier(
                    InkWell(
                      onTap: (() {
                        Navigator.pushNamed(
                            context, Routes.informationDevicePage);
                      }),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Información del dispositivo",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.graphic_eq,
                            color: Colors.red,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _contaier(Widget child) {
    return Container(
      height: 90,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            15), // Ajusta este valor para cambiar el radio de los bordes
        color:
            Colors.white, // Cambia el color del contenedor según lo necesites
      ),
      child: child,
    );
  }
}
