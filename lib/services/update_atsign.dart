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

  String message =
      '${currentAtsign} using ${hamradio.radioName} listening on ${frequencyFormat(hamradio.vfoaFrequency.toString()).padRight(10)} ${hamradio.vfoaModulationMode}';
  // Save radio Frequency and Mode
  var metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = false
    ..ttl = 3600000;

  var key = AtKey()
    ..key = hamradio.radioName
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  // key.metadata!.isPublic = key.sharedWith == null;
  print('Updating: ' + key.toString() + '  :::  ' + message + ' Mhz');
  await atClient.put(key, message);
  atClientManager.syncService.sync();
  var test = await atClient.get(key);
  if (test.value == null) {
    print('NULL FOUND');
  } else {
    print('Value::: ' + test.value);
  }
}
