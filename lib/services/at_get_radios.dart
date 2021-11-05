import 'dart:convert';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:hamlibui/models/radio_model.dart';

Future<List<HamRadio>> getHamradio(List<HamRadio> radios) async {
  String? currentAtsign;
  late AtClient atClient;
  late AtClientManager atClientManager;

  print('MADE IT TO METHOD');

  atClientManager = AtClientManager.getInstance();
  atClient = atClientManager.atClient;
  currentAtsign = atClient.getCurrentAtSign();
  currentAtsign = currentAtsign!.toUpperCase();

  var key = AtKey()
    ..key = 'numberRadios'
    ..sharedWith = currentAtsign;

  var atRadiocount = await atClient.get(key);
  if (atRadiocount.value != null) {
    List<HamRadio> newradios = [];
    print('GET RADIO COUNT:' + atRadiocount.value);
    var val = atRadiocount.value;
    int radioCount = int.parse(val);
    for (var i = 0; i < radioCount; i++) {
      print(i.toString());

      var key = AtKey()
        ..key = i.toString() + '.radio'
        ..sharedWith = currentAtsign;
      var value = await atClient.get(key);
      String valueString = value.value;

      var radioMap = jsonDecode(valueString);
      var newradio = HamRadio.fromJsonBasic(radioMap);
      newradios.add(newradio);
    }
    if (radios == newradios) return radios;

    if (radios.isEmpty) {
      radios = newradios;
    } else {
      var oldLength = radios.length;
      Map radioUuids = {};
      for (var old = 0; old < oldLength; old++) {
        radioUuids[old] = radios[old].radioUuid;
      }

      var newLength = newradios.length;
      Map newRadioUuids = {};
      for (var extra = 0; extra < newLength; extra++) {
        newRadioUuids[extra] = newradios[extra].radioUuid;
      }

      newRadioUuids.forEach((key, value) {
        if (radioUuids.containsValue(value)) {
        } else {
          radios.add(newradios[key]);
          print('Adding :' + newradios[key].radioName.toString());
        }
      });

      oldLength = radios.length;
      List radiosToRemove = [];
      radioUuids = {};
      for (var old = 0; old < oldLength; old++) {
        radioUuids[old] = radios[old].radioUuid;
      }

      radioUuids.forEach((key, value) {
        if (newRadioUuids.containsValue(value)) {
          print('NOT Removing :' + radios[key].radioName.toString());
        } else {
          radiosToRemove.add(key);
          print('Removing :' + radios[key].radioName.toString());
        }
      });
      for (var key in radiosToRemove) {
        radios.remove(radios[key]);
      }
    }
  }
  return (radios);
}
