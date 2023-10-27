import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/session/bloc/session_bloc.dart';
import '../../bloc/side_menu/side_menu_bloc.dart';
import '../../bloc/side_menu/side_menu_event.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SideMenuBloc sideMenuBloc = sl<SideMenuBloc>();
    final sessionBloc = sl<SessionBloc>();
    return SizedBox(
      width: MediaQuery.of(context).size.width *
          0.80, // 75% of screen will be occupied

      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: Drawer(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                builderHeader(context, sessionBloc),
                builderMenuItems(context, sideMenuBloc),
                builderBottonItems(context, sideMenuBloc)
              ],
            ),
          ),
        ),
      ),
    );
  }

  builderBottonItems(context, SideMenuBloc sideMenuBloc) {
    return Column(
      children: [
        itemButton(
          'Logout',
          () => sideMenuBloc.add(LogoutSideMenuEvent(context)),
          icon: Icon(Icons.logout_outlined),
          color: const Color.fromARGB(255, 117, 117, 117),
        )
      ],
    );
  }

  itemButton(text, onTap,
      {Icon? icon, Color color = const Color.fromARGB(255, 63, 62, 62)}) {
    /*icon = Icon(
      icon!.icon,
      color: color,
    );*/
    return ListTile(
      style: ListTileStyle.drawer,
      leading: icon,
      title: Text(
        text,
        style: TextStyle(fontSize: 16, color: color),
      ),
      onTap: onTap,
    );
  }

  itemButtonChilds(text, List<Widget> children, Icon icon,
      {Color color = const Color.fromARGB(255, 63, 62, 62)}) {
    icon = Icon(
      icon.icon,
      color: color,
    );

    return ExpansionTile(
        leading: icon,
        title: Text(
          text,
          style: TextStyle(fontSize: 16, color: color),
        ),
        children: children);
  }

  itemButtonChildsAdmin(text, List<Widget> children, Icon icon,
      {Color color = const Color.fromARGB(255, 63, 62, 62)}) {
    icon = Icon(
      icon.icon,
      color: color,
    );

    return ExpansionTile(
        leading: icon,
        title: Text(
          text,
          style: TextStyle(fontSize: 16, color: color),
        ),
        children: children);
  }

  itemChild(text, onTap) {
    return ListTile(
      //style: ListTileStyle.drawer,
      leading: Padding(
        padding: EdgeInsets.only(left: 50),
        child: Container(child: Text('-')),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 59, 59, 59)),
        textAlign: TextAlign.start,
      ),
      onTap: onTap,
    );
  }

  itemChildAdmin(text, onTap, List<Widget> childrenAdmin) {
    Widget child = ListTile(
      //style: ListTileStyle.drawer,
      leading: Padding(
        padding: EdgeInsets.only(left: 50),
        child: Container(child: Text('-')),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 59, 59, 59)),
        textAlign: TextAlign.start,
      ),
      onTap: onTap,
    );
    if (childrenAdmin != null) {
      Color color = const Color.fromARGB(255, 63, 62, 62);
      child = ExpansionTile(
          leading: Padding(
            padding: EdgeInsets.only(left: 50),
            child: Container(child: Text('-')),
          ),
          title: Text(
            text,
            style: TextStyle(fontSize: 16, color: color),
          ),
          children: childrenAdmin);
    }

    return child;
  }

  builderHeader(BuildContext context, SessionBloc sessionBloc) {
    return DrawerHeader(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          children: [
            Container(
              child: Image.asset('assets/images/user.png'),
              width: 50,
              height: 50,
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  sessionBloc.state.user!.name,
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  sessionBloc.state.user!.typeUser,
                  style: TextStyle(fontSize: 13),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  builderMenuItems(BuildContext context, SideMenuBloc sideMenuBloc) {
    bool isP = true;
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 16,
          children: [
            itemButton(
              'Profile',
              () {},
              icon: Icon(Icons.person_outline_rounded),
            ),
            itemButtonChilds(
              'Mi iglesia',
              [
                itemChild(
                  'Iglesia',
                  () {
                    //router.pushNamed(Routes.CHURCH);
                  },
                ),
                itemChild(
                  'Escuela sábatica',
                  () {
                    //router.pushNamed(Routes.EESS);
                  },
                ),
                isP
                    ? itemChild("Gestión EESS", () {
                        //router.pushNamed(Routes.ADMINEESS);
                      })
                    : const SizedBox()
              ],
              const Icon(Icons.other_houses_outlined),
            ),
            const Text('Actividades'),
            itemButtonChilds(
              'Proyectos',
              [
                itemChild(
                  'Proyecto Maná',
                  () {
                    //router.pushNamed(Routes.PROJECTS);
                  },
                ),
              ],
              const Icon(Icons.spoke_outlined),
            ),
            itemButton(
              'Eventos',
              () {},
              icon: Icon(Icons.event_outlined),
            ),
            Divider(),
            itemButton(
              'Recursos',
              () {},
              icon: Icon(Icons.folder_outlined),
            ),
            itemButton(
              'Configuración',
              () {},
              icon: Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
