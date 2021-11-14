import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:hamlibui/Theme/ui_theme.dart';
import 'package:hamlibui/models/radio_model.dart';
import 'package:hamlibui/services/formats.dart';
import 'package:hamlibui/services/rigctld.dart';
import 'package:timer_builder/timer_builder.dart';

class RadioCard extends StatefulWidget {
  final HamRadio hamradio;
  final VoidCallback? deleteradio;
  final VoidCallback? editradio;
  final Function activeradio;
  final Function activateradio;

  const RadioCard({
    Key? key,
    required this.hamradio,
    required this.deleteradio,
    required this.editradio,
    required this.activeradio,
    required this.activateradio,
  }) : super(key: key);

  @override
  _RadioCardState createState() => _RadioCardState();
}

class _RadioCardState extends State<RadioCard> {
  _RadioCardState();

  @override
  Widget build(BuildContext context) {
    HamRadio radio = widget.hamradio;
    VoidCallback? deletecard = widget.deleteradio;
    VoidCallback? editcard = widget.editradio;
    Function activeradio = widget.activeradio;
    Function activateradio = widget.activateradio;
    return TimerBuilder.periodic(const Duration(milliseconds: 1000),
        builder: (context) {
      // If the ham radio is active then lets get the
      // frequency and modes... If not then set default.
      if (activeradio()) {
        rigCTLd(widget.hamradio);
      } 
      return ExpansionTileCard(
          baseColor: UItheme.richBlackFOGRA29,
          expandedColor: UItheme.richBlackFOGRA29,
          expandedTextColor: Colors.white,
          initiallyExpanded: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(radio.radioName,
                  style:
                      // ignore: prefer_const_constructors
                      TextStyle(
                          fontFamily: 'LED',
                          fontSize: 30,
                          letterSpacing: 5,
                          color: Colors.green)),
              // ignore: prefer_const_constructors
              Text(
                  "VFO A ${frequencyFormat(radio.vfoaFrequency.toString()).padRight(10)} ${radio.vfoaModulationMode.toString()}",
                  style:
                      // ignore: prefer_const_constructors
                      TextStyle(
                          fontFamily: 'LED',
                          fontSize: 30,
                          letterSpacing: 5,
                          color: Colors.white)),
              // ignore: prefer_const_constructors
              // VFO B when we need it
              // Text(
              //     "VFO B ${frequencyFormat(radio.vfobFrequency.toString()).padRight(10)} ${radio.vfobModulationMode.toString()}",
              //     style:
              //         // ignore: prefer_const_constructors
              //         TextStyle(
              //             fontFamily: 'LED',
              //             fontSize: 30,
              //             letterSpacing: 5,
              //             color: Colors.white)),
            ],
          ),
          children: <Widget>[
            const SizedBox(height: 12.0),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IP ADDRESS  ${radio.ipAddress}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'LED',
                          letterSpacing: 5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PORT NUMBER  ${radio.portNumber}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'LED',
                      letterSpacing: 5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(children: [
              Row(children: [
                TextButton.icon(
                    onPressed: deletecard,
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'DELETE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'LED',
                          letterSpacing: 5),
                    )),
                const Spacer(),
                TextButton.icon(
                  onPressed: editcard,
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    'EDIT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'LED',
                        letterSpacing: 5),
                  ),
                ),
                const Spacer(),
              ]),
              Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: CheckboxListTile(
                    value: widget.activeradio(),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {
                      setState(() {
                        activateradio.call(newValue);
                      });
                    },
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    selectedTileColor: Colors.white,
                    //tileColor: Colors.white,
                    title: const Text(
                      'ACTIVE',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'LED',
                          letterSpacing: 5),
                    ),
                  ))
            ])
          ]);
    });
  }
}
