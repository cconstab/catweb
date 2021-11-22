import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:auto_size_text/auto_size_text.dart';


import 'package:catweb/theme/ui_theme.dart';
import 'package:catweb/models/radio_model.dart';
import 'package:catweb/forms/radioforms.dart';

class NewRadio extends StatefulWidget {
  const NewRadio({Key? key}) : super(key: key);
  static const String id = '/newradio';

  @override
  _NewRadioState createState() => _NewRadioState();
}

class _NewRadioState extends State<NewRadio> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: UItheme.richBlackFOGRA29,
            appBar: AppBar(
              titleTextStyle: const TextStyle(
                  fontFamily: 'LED', fontSize: 36, letterSpacing: 5),
              title: const Text(
                'NEW RADIO',
                textAlign: TextAlign.center,
              ),
              backgroundColor: UItheme.viridianGreen,
            ),
            body: FormBuilder(
                key: _formKey,
                child: Column(children: [
                  radioNameForm(context, ''),
                  radioFormIP(context, ''),
                  radioFormPort(context, ''),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 20),
                                             Expanded(
                        child: BackButton(
                            color: UItheme.viridianGreen,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            ),
                      ),
                      const Spacer(),
                      RadioSubmitForm(formKey: _formKey),
                      const Spacer(),
                      Expanded(
                        child: MaterialButton(
                          color: UItheme.viridianGreen,
                          child:  const AutoSizeText("Submit",
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                            maxFontSize: 30,
                            minFontSize: 10,
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
                              var newradio = HamRadio(
                                  radioName: radioname,
                                  radioUuid: UniqueKey().toString(),
                                  // active: false,
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
                ]))));
  }
}
