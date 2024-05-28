import 'package:flutter/material.dart';

class ItemProfile extends StatelessWidget {
  ItemProfile({
    required this.title,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 51, 51, 51),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.edit),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
