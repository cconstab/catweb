import 'package:at_commons/at_commons.dart';
import 'dart:convert';

import 'package:hamlibui/main.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
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
      'https://cconstab.github.io/cateyes/?atsign=${currentAtsignNoAt.toLowerCase()}&radio=${hamradio.radioName.toLowerCase()}';

//Previous Attempts :-)
//  String wavi =
//       '''{"label":"Listening on ${hamradio.radioName}","category":"DETAILS","type":"Text","value":"<iframe src=\\"$radiourl\\"  style=\\"height:90px;width:900px\\"</iframe>","valueLabel":""}''';
// String html = '''<!DOCTYPE html><html><head><meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1\\"><style>.container {  position: relative;  width: 100%;  overflow: hidden;  padding-top: 56.25%;} .responsive-iframe {  position: absolute;  top: 0;  left: 0;  bottom: 0;  right: 0;  width: 100%;  height: 100%;  border: none;</style></head><body><div class=\\"container\\">  <iframe class=\\"responsive-iframe\\" src=\\"$radiourl\\"></iframe></div></body</html>  ''';
// String html = '''<html><head><meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1\\"><style>.container {  position: relative;  width: 100%;  overflow: hidden;  padding-top: 10%;} .responsive-iframe {  position: absolute;  top: 0;  left: 0;  bottom: 0;  right: 0;  width: 100%;  height: 100%;  border: none;</style></head><body><div class=\\"container\\">  <iframe class=\\"responsive-iframe\\" src=\\"$radiourl\\"></iframe></div></body</html>  ''';
//String html = '''<html><head><meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1\\"><style>.container {  position: relative;  width: 100%;  overflow: hidden;  padding-top: 10%;} .responsive-iframe {  width: 100%;  height: 100%;  border: none;</style></head><body><div class=\\"container\\">  <iframe class=\\"responsive-iframe\\" src=\\"$radiourl\\"></iframe></div></body</html>  ''';

  String html =
      '''<html><head><meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1\\"><style>.container {  position: relative;  width: 100%;  overflow: hidden;  } .responsive-iframe {  position: absolute;  top: 0;  left: 0;  bottom: 0;  right: 0;  width: 100%;  height: 100%;  border: none;} .pt-10{padding-top: 10%;}</style></head><body><div class=\\"container pt-10\\">  <iframe class=\\"responsive-iframe\\" src=\\"$radiourl\\"></iframe></div></body</html>''';

  String wavi =
      '''{"label":"Listening on ${hamradio.radioName}","category":"DETAILS","type":"Text","value":"$html","valueLabel":""}''';

  var metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..namespaceAware = true
    // // one minute
    // ..ttl = 60000 ;
    // One Hour
    ..ttl = 3600000;

  var key = AtKey()
    ..key = 'public.' + hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  print('Updating: ' + key.toString() + '  :::  ' + jsonEncode(publichamradio));
  //await atClient.delete(key);
  await atClient.put(key, jsonEncode(publichamradio));
  //atClientManager.syncService.sync();
  var test = await atClient.get(key);
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
  print('QRT pref:::' + preference.namespace.toString());

  atClientManager.atClient.setPreferences(preference);

  PublicHamRadio publichamradio =
      PublicHamRadio.fromJson(hamradio.toJsonFull());

  publichamradio.vfoaFrequency = '8888888888';
  publichamradio.vfoaModulationMode = 'QRT';

  var metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..namespaceAware = true
    // // one minute
    // ..ttl = 60000 ;
    // One Hour
    ..ttl = 3600000;

  var key = AtKey()
    ..key = 'public.' + hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  print('Updating QRT: ' +
      key.toString() +
      '  :::  ' +
      jsonEncode(publichamradio));
  //await atClient.delete(key);
  await atClient.put(key, jsonEncode(publichamradio));
  //atClientManager.syncService.sync();
  var test = await atClient.get(key);
  if (test.value == null) {
    print('QRT NULL FOUND');
  } else {
    print('QRT JSON VALUE::: ' + test.value);
  }
}
