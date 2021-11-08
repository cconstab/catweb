import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';

import 'package:hamlibui/main.dart';

import 'package:hamlibui/models/radio_model.dart';
import 'package:hamlibui/models/public_radio_model.dart';


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

  PublicHamRadio publichamradio =
      PublicHamRadio.fromJson(hamradio.toJsonFull());
  
var metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..namespaceAware = true
    // // one minute
    // ..ttl = 60000 ;
    // One Hour
    ..ttl = 3600000;

  var key = AtKey()
    ..key = 'public.'+hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  print('Updating: ' + key.toString() + '  :::  ' + publichamradio.toJson().toString());
  //await atClient.delete(key);
  await atClient.put(key, publichamradio.toJson().toString());
  atClientManager.syncService.sync();
  var test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('JSON VALUE::: ' + test.value);
  }


}
