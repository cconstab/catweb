import 'dart:io';

import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:hamlibui/services/update_atsign.dart';
import 'package:mdi/mdi.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:hamlibui/Theme/ui_theme.dart';

import 'package:hamlibui/screens/new_radio.dart';
import 'package:hamlibui/screens/edit_radio.dart';
import 'package:hamlibui/models/radio_model.dart';
import 'package:hamlibui/services/reset_radio_display.dart';
import 'package:hamlibui/widgets/radio_card.dart';
import 'package:hamlibui/services/at_save_radio.dart';
import 'package:hamlibui/services/at_get_radios.dart';

// Saves some typing if you need some radios
// import 'package:ui/data/radios.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String id = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? currentAtsign;
  late AtClient atClient;
  late AtClientManager atClientManager;
  List<HamRadio> radios = [];
  List activeradios = [];

  @override
  void initState() {
    super.initState();
    atClientManager = AtClientManager.getInstance();
    atClient = atClientManager.atClient;
    currentAtsign = atClient.getCurrentAtSign();
    currentAtsign = currentAtsign!.toUpperCase();
    final syncService = atClientManager.syncService;
    syncService.setOnDone(_syncRadios);
    print(syncService.isSyncInProgress.toString() + ' Syncing ');
    initRadios();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    radios.sort((a, b) {
      return compareAsciiUpperCase(a.radioName, b.radioName);
    });
    radios.sort((a, b) {
      if (activeradios.contains(b.radioUuid)) {
        return 1;
      }
      return -1;
    });
  }

  void _syncRadios(synchResult) {
    print('SYNC COMPLETE RUNNING initRADIOS');
    initRadios();
  }

  Future<void> initRadios() async {
    print('GETTING RADIOS');
    radios = await getHamradio(radios);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          backgroundColor: UItheme.richBlackFOGRA29,
          appBar: AppBar(
            titleTextStyle: const TextStyle(
                fontFamily: 'LED', fontSize: 36, letterSpacing: 5),
            title: Text(
              '$currentAtsign CATWEB',
            ),
            actions: [
              PopupMenuButton<String>(
                color: UItheme.viridianGreen,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                icon: const Icon(
                  Icons.menu,
                  size: 50,
                ),
                onSelected: (String result) {
                  switch (result) {
                    case 'CLOSE':
                      saveHamradio(radios);
                      print(radios);
                      exit(0);
                    //break;
                    default:
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'CLOSE',
                    child: Text(
                      'CLOSE',
                      style: TextStyle(
                          fontFamily: 'LED',
                          fontSize: 30,
                          letterSpacing: 5,
                          backgroundColor: UItheme.viridianGreen,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
            backgroundColor: UItheme.viridianGreen,
            foregroundColor: Colors.white,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: UItheme.viridianGreen,
            onPressed: () async {
              HamRadio? newradio = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewRadio()),
              );
              if (newradio != null) {
                setState(() {
                  radios.add(newradio);
                  saveHamradio(radios);
                });
              }
            },
            child: const Icon(Mdi.plus),
          ),
          body: ListView(
            children: radios
                .map((hamradio) => RadioCard(
                      key: UniqueKey(),
                      hamradio: hamradio,
                      deleteradio: () {
                        setState(() {
                          radios.remove(hamradio);
                          saveHamradio(radios);
                        });
                      },
                      editradio: () async {
                        HamRadio edithamradio =
                            radios[radios.indexOf(hamradio)];
                        HamRadio? editedhamradio = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditRadio(edithamradio: edithamradio),
                            ));
                        if (editedhamradio != null) {
                          radios.remove(hamradio);
                          editedhamradio.radioUuid = UniqueKey().toString();
                          radios.insert(0, editedhamradio);
                          saveHamradio(radios);
                        }

                        setState(() {});
                      },
                      activateradio: (newvalue) {
                        setState(() {
                          if (newvalue) {
                            activeradios.add(hamradio.radioUuid);
                          } else {
                            activeradios.remove(hamradio.radioUuid);
                            resetRadioDisplay(hamradio);
                            qrtAtsign(hamradio);
                          }
                        });
                      },
                      activeradio: () {
                        if (activeradios.contains(hamradio.radioUuid)) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                    ))
                .toList(),
          )),
    );
  }
}
