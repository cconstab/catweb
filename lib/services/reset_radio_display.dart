
import 'package:hamlibui/models/radio_model.dart';

resetRadioDisplay(HamRadio hamradio) async {
  await Future.delayed(const Duration(seconds: 5));
  hamradio.vfoaFrequency = '0000000000';
  hamradio.vfoaModulationMode = '---';
  hamradio.vfobFrequency = '0000000000';
  hamradio.vfobModulationMode = '---';
}
