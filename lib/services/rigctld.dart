import 'dart:io';
import 'dart:typed_data';

import 'package:hamlibui/models/radio_model.dart';
import 'package:hamlibui/services/update_atsign.dart';

void rigCTLd(HamRadio hamradio) async {
  String serverResponse = '';

  // connect to the socket server
  try {
    final socket = await Socket.connect(
        hamradio.ipAddress,
        int.parse(
          hamradio.portNumber,
        ),
        timeout: const Duration(seconds: 3));

    socket.listen(
      // handle data from the server
      (Uint8List data) {
        serverResponse = String.fromCharCodes(data);

        // Grab Frequency)
        if (serverResponse.contains('get_freq:-Frequency:') &&
            serverResponse.contains('-RPRT 0')) {
          var freq = serverResponse.split(' ');
          String frequency = freq[1];
          frequency = frequency.replaceFirst(RegExp('r*-RPRT'), '');
          hamradio.vfoaFrequencyLast = hamradio.vfoaFrequency;
          hamradio.vfoaFrequency = frequency;
        }
        // Grab Modulation Mode
        // Be aware sometimes the TCP packet
        // Can include both Frequency and Modulation Mode
        // Hence fancy RegExp!
        if (serverResponse.contains('get_mode:-Mode:') &&
            serverResponse.contains('Passband:')) {
          String mode =
              serverResponse.replaceFirst(RegExp('((.|\n)*).+?(?=Mode)'), '');
          List modelist = mode.split(' ');
          String mmode = modelist[1];
          mmode = mmode.replaceFirst(RegExp('r*-Passband:'), '');
          // If no Modulation mode give then
          // Likley Digital or Dstar
          // At least on Icom
          if (mmode == '') {
            mmode = 'DIG';
          }
          hamradio.vfoaModulationModeLast = hamradio.vfoaModulationMode;
          hamradio.vfoaModulationMode = mmode;
        }
        if (hamradio.vfoaFrequency != hamradio.vfoaFrequencyLast || hamradio.vfoaModulationMode != hamradio.vfoaModulationModeLast ) {
            updateAtsign(hamradio);
          }
        hamradio.errors = 0;
      },

      // handle errors
      onError: (error) {
        // hamradio.vfoaFrequency = "8888888888";
        // hamradio.vfoaModulationMode = 'ERR';
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        socket.destroy();
      },
    );

    await sendMessage(socket, '-f\r-m\r');
    // } on SocketException {
    //   hamradio.vfoaFrequency = '8888888888';
    //   hamradio.vfoaModulationMode = 'ERR';
  } catch (e) {
    hamradio.errors++;
    print(e.toString() + 'errors:' + hamradio.errors.toString());
    if (hamradio.errors > 4) {
      hamradio.vfoaFrequency = "8888888888";
      hamradio.vfoaModulationMode = 'ERR';
    }
  }
}

Future<void> sendMessage(Socket socket, String message) async {
  socket.write(message);
  await Future.delayed(const Duration(seconds: 1));
  socket.destroy();
}
