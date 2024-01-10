import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/config/utils/my_colors.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_event.dart';
import 'package:flutter_application_prgrado/presentation/bloc/home/home_state.dart';
import 'package:flutter_application_prgrado/presentation/bloc/session/bloc/session_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/camera_managment/camera_managment.dart';
import 'package:flutter_application_prgrado/presentation/pages/camera_managment/camera_managment2.dart';
import 'package:flutter_application_prgrado/presentation/pages/camera_managment/prueba.dart';
import 'package:flutter_application_prgrado/presentation/pages/gestion/gestion_page.dart';
import 'package:flutter_application_prgrado/presentation/pages/gestion_page/gestion_page.dart';
import 'package:flutter_application_prgrado/presentation/pages/home/widgets/button_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/information_driver_page.dart';
import 'package:flutter_application_prgrado/presentation/widgets/appBar/appBar_custom.dart';
import 'package:flutter_application_prgrado/presentation/widgets/side_menu/side_menu.dart';
import 'package:flutter_application_prgrado/presentation/widgets/text/custom_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final list = <Widget>[
    const InformationDeviceView(),
    const CameraManagmentPage(),
    const GestionPrototypePage()
  ];

  @override
  Widget build(BuildContext context) {
    final session = sl<SessionBloc>();
    final bloc = sl<HomeBloc>()..add(const InitHomeEvent());
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBarCustom(
          title: '',
          background: Color(0xFF151515),
          elevation: 0,
        ),*/
        //drawer: const NavigatorDrawer(),
        body: Container(
          padding: EdgeInsets.all(8),
          color: Color(0xFF151515),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo1.png',
                    width: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10), // Ajusta este valor para cambiar el radio de los bordes
                      color: Color.fromARGB(255, 51, 51,
                          51), // Cambia el color del contenedor según lo necesites
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ), // I
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTitle3(
                      title: "Bienvenido, ${session.state.user!.name}",
                      colorTitle: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  /*Center(
                    child: Lottie.asset(
                      'assets/lottie/Animation - 1699345190736.json', // Ruta a tu archivo JSON de animación
                      width: 100, // Ajusta el ancho según tus preferencias
                      height: 100, // Ajusta la altura según tus preferencias
                    ),
                  )*/
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(children: [
                          Icon(
                            Icons.circle,
                            color: Color.fromARGB(255, 96, 109, 204),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Conectado",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Ajusta este valor para cambiar el radio de los bordes
                                  color: Color.fromARGB(255, 51, 51,
                                      51), // Cambia el color del contenedor según lo necesites
                                ),
                                child: Icon(
                                  Icons.verified_outlined,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  print("tap");
                                },
                                child: Text(
                                  "Verificar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BlocSelector<HomeBloc, HomeState, int?>(
                  bloc: bloc,
                  selector: (state) => state.index,
                  builder: (context, index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonWidget(
                            text: 'Información',
                            isSelected: index == 0,
                            ontap: () {
                              bloc.add(IndexChangedHomeEvent(0));
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ButtonWidget(
                            text: 'Camaras',
                            isSelected: index == 1,
                            ontap: () {
                              bloc.add(IndexChangedHomeEvent(1));
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ButtonWidget(
                            text: 'Diagnosticar',
                            isSelected: index == 2,
                            ontap: () {
                              bloc.add(IndexChangedHomeEvent(2));
                            },
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Container(
                  child: BlocSelector<HomeBloc, HomeState, int?>(
                    bloc: bloc,
                    selector: (state) => state.index,
                    builder: (context, index) {
                      if (index == null) {
                        return SizedBox();
                      }
                      return list[index];
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _itemButton(
    String text,
    bool isSelected,
    void Function() ontap,
  ) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              30), // Ajusta este valor para cambiar el radio de los bordes
          color: Color.fromARGB(
            255,
            51,
            51,
            51,
          ), // Cambia el color del contenedor según lo necesites
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  _contaier(Widget child, {Color color = Colors.white}) {
    return Container(
      height: 90,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            15), // Ajusta este valor para cambiar el radio de los bordes
        color: color, // Cambia el color del contenedor según lo necesites
      ),
      child: child,
    );
  }
}
