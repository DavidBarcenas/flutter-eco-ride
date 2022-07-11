import 'package:ecoride/resources/ride_colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 210,
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5.0, spreadRadius: 0.5, offset: Offset(0.7, 0.7))
          ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 20),
            child: Column(children: [
              const SizedBox(
                height: 5.0,
              ),
              Stack(
                children: [
                  GestureDetector(child: const Icon(Icons.arrow_back), onTap: () => Navigator.pop(context)),
                  const Center(
                    child: Text('Agregar destino', style: TextStyle(fontSize: 20, fontFamily: 'Brand-Bold')),
                  )
                ],
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(
                children: [
                  Image.asset(
                    'images/pickicon.png',
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 18.0,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(color: RideColors.lightGrayFair, borderRadius: BorderRadius.circular(4)),
                    child: const TextField(
                        decoration: InputDecoration(
                            hintText: 'Lugar de ecuentro',
                            fillColor: RideColors.lightGrayFair,
                            filled: true,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.only(left: 20, top: 8, bottom: 8))),
                  ))
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
              Row(
                children: [
                  Image.asset(
                    'images/desticon.png',
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 18.0,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(color: RideColors.lightGrayFair, borderRadius: BorderRadius.circular(4)),
                    child: const TextField(
                        decoration: InputDecoration(
                            hintText: '¿A dónde?',
                            fillColor: RideColors.lightGrayFair,
                            filled: true,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.only(left: 20, top: 8, bottom: 8))),
                  ))
                ],
              )
            ]),
          ),
        )
      ],
    ));
  }
}
