import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';

import 'package:catweb/main.dart';

import 'package:catweb/models/radio_model.dart';
import 'package:catweb/models/public_radio_model.dart';

resetRadioDisplay(HamRadio hamradio) async {
  String? currentAtsign;
  late AtClient atClient;
  late AtClientManager atClientManager;

  atClientManager = AtClientManager.getInstance();
  atClient = atClientManager.atClient;
  currentAtsign = atClient.getCurrentAtSign();
  var currentAtsignNoAt = currentAtsign!.replaceAll('@', '');
  Future<AtClientPreference> futurePreference = loadAtClientPreference();

  var preference = await futurePreference;

  print('PPPPPPref' + preference.namespace.toString());

  atClientManager.atClient.setPreferences(preference);

  await Future.delayed(const Duration(seconds: 5));
  hamradio.vfoaFrequency = '0000000000';
  hamradio.vfoaModulationMode = '---';
  hamradio.vfobFrequency = '0000000000';
  hamradio.vfobModulationMode = '---';
}
