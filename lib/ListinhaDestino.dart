import 'package:flutter/material.dart';

class Listinhadestino extends StatelessWidget {
  final String Ciudad;
  final double distancia;
  final Function() onRemoved;

  const Listinhadestino(
      {required this.Ciudad,
      required this.distancia,
      required this.onRemoved,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          onRemoved();
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 15, 35, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.pin_drop_outlined,
                  color: Colors.lightGreen,
                ),
                Text(
                  Ciudad,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$distancia",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Quilômetros",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
