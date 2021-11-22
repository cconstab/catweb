import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:catweb/theme/ui_theme.dart';
import 'package:catweb/models/radio_model.dart';
import 'package:catweb/forms/radioforms.dart';

class EditRadio extends StatefulWidget {
  final HamRadio edithamradio;

  const EditRadio({Key? key, required this.edithamradio}) : super(key: key);
  static const String id = '/editradio';

  @override
  _EditRadioState createState() => _EditRadioState();
}

class _EditRadioState extends State<EditRadio> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    HamRadio edithamradio = widget.edithamradio;

    return MaterialApp(
        home: Scaffold(
            backgroundColor: UItheme.richBlackFOGRA29,
            appBar: AppBar(
              titleTextStyle: const TextStyle(
                  fontFamily: 'LED', fontSize: 36, letterSpacing: 5),
              title: const Text(
                'EDIT RADIO',
                textAlign: TextAlign.center,
              ),
              backgroundColor: UItheme.viridianGreen,
            ),
            body: FormBuilder(
                key: _formKey,
                child: Column(children: [
                  radioNameForm(context, edithamradio.radioName),
                  radioFormIP(context, edithamradio.ipAddress),
                  radioFormPort(context, edithamradio.portNumber),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 20),
                      RadioSubmitForm(formKey: _formKey),
                      const Spacer(),
                      Expanded(
                        child: MaterialButton(
                          color: UItheme.viridianGreen,
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              String radioname = _formKey
                                  .currentState!.fields['radioName']!.value;
                              String ipaddress = _formKey
                                  .currentState!.fields['ipAddress']!.value;
                              String portnumber = _formKey
                                  .currentState!.fields['portNumber']!.value;
                              // int portnumberint = int.parse(portnumber);
                              // print(_formKey.currentState!.value);
                              var newradio = HamRadio.edited(
                                  radioName: radioname,
                                  radioUuid: edithamradio.radioUuid,
                                  // vfoaFrequency: 0,
                                  // vfoaModulationMode: '',
                                  // vfoaOperatingMode: '',
                                  // vfobFrequency: 0,
                                  // vfobModulationMode: '',
                                  // vfobOperatingMode: '',
                                  ipAddress: ipaddress,
                                  portNumber: portnumber);
                              Navigator.pop(context, newradio);
                            } else {
                              print("validation failed");
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  )
                ]
              )
            )
          )
        );
  }
}
