import 'package:at_commons/at_commons.dart';
import 'dart:convert';

import 'package:hamlibui/main.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:hamlibui/services/formats.dart';
import 'package:hamlibui/models/radio_model.dart';
import 'package:hamlibui/models/public_radio_model.dart';

updateAtsign(HamRadio hamradio) async {
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

  PublicHamRadio publichamradio =
      PublicHamRadio.fromJson(hamradio.toJsonFull());

  print(publichamradio.toJson());

  String radiourl =
      // 'https://wavi.ng/api?atp=${hamradio.radioName}.$currentAtsignNoAt@ai6bh&html=true';
      //'http://wavi.shaduf.com:8080/?atsign=$currentAtsignNoAt&radio=${hamradio.radioName}';
      'https://cconstab.github.io/cateyes/?atsign=${currentAtsignNoAt.toLowerCase()}&radio=${hamradio.radioName.toLowerCase()}';
  String wavi =
      '''{"label":"Listening on ${hamradio.radioName}","category":"DETAILS","type":"Text","value":"<iframe src=\\"$radiourl\\"  style=\\"height:90px;width:900px\\"</iframe>","valueLabel":""}''';

  String message =
      '<!DOCTYPE html> <html> <head> <meta http-equiv="refresh" content="5" /><style> h1 {text-align: center;} </style> </head><body> <h1>${currentAtsign.toUpperCase()} using ${hamradio.radioName} listening on ${frequencyFormat(hamradio.vfoaFrequency.toString()).padRight(10)} ${hamradio.vfoaModulationMode} </h1> </body> </html>';

  String qrt =
      '<!DOCTYPE html> <html> <head> <meta http-equiv="refresh" content="5" /><style> h1 {text-align: center;} </style> </head><body> <h1>${currentAtsign.toUpperCase()} using ${hamradio.radioName} QRT for now </h1> </body> </html>';
  // Save radio Frequency and Mode
  var metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..namespaceAware = true
    // // one minute
    // ..ttl = 60000 ;
    // One Hour
    ..ttl = 3600000;

  var key = AtKey()
    ..key = hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  print('Updating: ' + key.toString() + '  :::  ' + message + ' Mhz');
  //await atClient.delete(key);
  await atClient.put(key, message);
  //atClientManager.syncService.sync();
  var test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('RADIO VALUE::: ' + test.value);
  }

  metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..namespaceAware = true
    // // one minute
    // ..ttl = 60000 ;
    // One Hour
    ..ttl = 3600000;

  key = AtKey()
    ..key = 'public.' + hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  print('Updating: ' + key.toString() + '  :::  ' + jsonEncode(publichamradio));
  //await atClient.delete(key);
  await atClient.put(key, jsonEncode(publichamradio));
  //atClientManager.syncService.sync();
  test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('JSON VALUE::: ' + test.value);
  }

  key = AtKey()
    ..key = hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  String wavikey = 'custom_' + hamradio.radioName + '.wavi';

  metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..namespaceAware = false
    // // one minute
    // ..ttl = 60000 ;
    // One Hour
    ..ttl = 3600000;
  key = AtKey()
    ..key = wavikey
    ..sharedBy = currentAtsign
    // ..namespace = 'wavi'
    ..metadata = metaData;

  print('+++++++++++++++++++++++++++++++');
  await atClient.put(key, wavi);
  print('Putting this Key::' + key.toString());
  print('+++++++++++++++++++++++++++++++');

  //atClientManager.syncService.sync();
  test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('WAVI VALUE::: ' + test.value);
    print('WAVI VALUE::: ' + test.metadata.toString());
  }
}

qrtAtsign(HamRadio hamradio) async {
  String? currentAtsign;
  late AtClient atClient;
  late AtClientManager atClientManager;

  atClientManager = AtClientManager.getInstance();
  atClient = atClientManager.atClient;
  currentAtsign = atClient.getCurrentAtSign();

  AtClientPreference? atClientPreference;
  Future<AtClientPreference> futurePreference = loadAtClientPreference();

  var preference = await futurePreference;
  print('pref:::' + preference.namespace.toString());

  atClientManager.atClient.setPreferences(preference);

  String qrt =
      '<!DOCTYPE html> <html> <head> <meta http-equiv="refresh" content="5" /><style> h1 {text-align: center;} </style> </head><body> <h1>${currentAtsign!.toUpperCase()} using ${hamradio.radioName} QRT for now </h1> </body> </html>';
  // Save radio Frequency and Mode
  var metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..namespaceAware = true
    // // one minute
    // ..ttl = 60000 ;
    // One Hour
    ..ttl = 3600000;

  var key = AtKey()
    ..key = hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  print('Updating: ' + key.toString() + '  :::  ' + qrt);
  await atClient.delete(key);
  await atClient.put(key, qrt);

  atClientManager.syncService.sync();
  var test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('RADIO VALUE::: ' + test.value);
  }
}
