import 'package:at_commons/at_commons.dart';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:hamlibui/services/formats.dart';
import 'package:hamlibui/models/radio_model.dart';

updateAtsign(HamRadio hamradio) async {
  String? currentAtsign;
  late AtClient atClient;
  late AtClientManager atClientManager;

  atClientManager = AtClientManager.getInstance();
  atClient = atClientManager.atClient;
  currentAtsign = atClient.getCurrentAtSign();
  var currentAtsignNoAt = currentAtsign!.replaceAll('@', '');

  String radiourl =
      'https://wavi.ng/api?atp=${hamradio.radioName}.$currentAtsignNoAt@ai6bh&html=true';
  String wavi =
      '''{"label":"Listening on ${hamradio.radioName}","category":"DETAILS","type":"Text","value":"<iframe src=\\"$radiourl\\" sandbox=\\"allow-scripts\\"  style=\\"height:75px;width:1100px\\" title=\\"Iframe Example\\"></iframe>","valueLabel":""}''';

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
  atClientManager.syncService.sync();
  var test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('RADIO VALUE::: ' + test.value);
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

  atClientManager.syncService.sync();
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
  var currentAtsignNoAt = currentAtsign!.replaceAll('@', '');
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

  print('Updating: ' + key.toString() + '  :::  ' + qrt + ' Mhz');
  //await atClient.delete(key);
  await atClient.put(key, qrt);
  atClientManager.syncService.sync();
  var test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('RADIO VALUE::: ' + test.value);
  }

}
