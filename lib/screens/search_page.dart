import 'package:ecoride/helpers/request.dart';
import 'package:ecoride/providers/app_data.dart';
import 'package:ecoride/resources/ride_colors.dart';
import 'package:ecoride/resources/strings.dart';
import 'package:ecoride/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '../models/prediction.dart';
import '../widgets/prediction_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();
  var focusDestination = FocusNode();
  bool focused = false;
  List<Prediction> destinationPredictionList = [];

  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  void searchPlace(String placeName) async {
    if (placeName.length > 3) {
      var response = await Request.getRequest(dotenv.get('PLACE_API_DOMAIN'), dotenv.get('PLACE_API_ENDPOINT'),
          {'text': placeName, 'apiKey': dotenv.get('PLACE_API_KEY')});
      if (response == Strings.requestFailed) {
        return;
      }
      if (response['features']) {
        var predictionsJson = response['features'];
        var predictions = (predictionsJson as List).map((e) => Prediction.fromJson(e)).toList();
        setState(() => destinationPredictionList = predictions);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    String address = Provider.of<AppData>(context).pickupAddress.locality;
    pickupController.text = address;

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
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                          controller: pickupController,
                          decoration: const InputDecoration(
                              hintText: 'Lugar de ecuentro',
                              fillColor: RideColors.lightGrayFair,
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8))),
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 10.0,
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
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                          onChanged: (value) => searchPlace(value),
                          focusNode: focusDestination,
                          controller: destinationController,
                          decoration: const InputDecoration(
                              hintText: '¿A dónde?',
                              fillColor: RideColors.lightGrayFair,
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8))),
                    ),
                  ))
                ],
              )
            ]),
          ),
        ),
        (destinationPredictionList.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListView.separated(
                  itemBuilder: ((context, index) => PredictionTile(prediction: destinationPredictionList[index])),
                  separatorBuilder: ((BuildContext context, int index) => const CustomDivider()),
                  itemCount: destinationPredictionList.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                ),
              )
            : Container()
      ],
    ));
  }
}
