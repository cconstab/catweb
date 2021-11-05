import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:hamlibui/theme/ui_theme.dart';

// Some Form teamplating to resuse in New and Edit Radio
 
 FormBuilderTextField radioFormPort(BuildContext context, String initialvalue) {
    return FormBuilderTextField(
                    initialValue: initialvalue.toString(),
                    name: 'portNumber',
                    decoration: const InputDecoration(
                      labelText: 'PORT NUMBER',
                      fillColor: Colors.white,
                      focusColor: Colors.lightGreenAccent,
                      labelStyle: TextStyle(
                        color: UItheme.viridianGreen,
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.max(context, 65535),
                      FormBuilderValidators.min(context, 1025),
                       FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                    style: const TextStyle(
                        color: UItheme.viridianGreen,
                        fontSize: 30,
                        fontFamily: 'LED',
                        letterSpacing: 5));
  }

  FormBuilderTextField radioFormIP(BuildContext context,String initialvalue) {
    return FormBuilderTextField(
                    initialValue: initialvalue,
                    name: 'ipAddress',
                    decoration: const InputDecoration(
                      labelText: 'IP/DNS ADDRESS',
                      fillColor: Colors.white,
                      focusColor: Colors.lightGreenAccent,
                      labelStyle: TextStyle(
                        color: UItheme.viridianGreen,
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.url(context,
                          errorText: 'Enter Valid Address'),
                        
                      FormBuilderValidators.required(context),
                    ]),
                    style: const TextStyle(
                        color: UItheme.viridianGreen,
                        fontSize: 30,
                        fontFamily: 'LED',
                        letterSpacing: 5));
  }

  FormBuilderTextField radioNameForm(BuildContext context,String initialvalue) {
    return FormBuilderTextField(
                    initialValue: initialvalue,
                    textCapitalization: TextCapitalization.characters,
                    name: 'radioName',
                    decoration: const InputDecoration(
                      labelText: 'RADIO NAME',
                      fillColor: Colors.white,
                      focusColor: Colors.lightGreenAccent,
                      labelStyle: TextStyle(
                        color: UItheme.viridianGreen,
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.maxLength(context, 16),
                      FormBuilderValidators.minLength(context, 4),
                      FormBuilderValidators.match(context, '^[a-zA-Z0-9_.]*\$',errorText: 'Alphanumeric or _ Only'),
                      FormBuilderValidators.required(context)
                    ]),
                    style: const TextStyle(
                        color: UItheme.viridianGreen,
                        fontSize: 30,
                        fontFamily: 'LED',
                        letterSpacing: 5));
  }

          class RadioSubmitForm extends StatelessWidget {
          const RadioSubmitForm({
            Key? key,
            required GlobalKey<FormBuilderState> formKey,
          }) : _formKey = formKey, super(key: key);

          final GlobalKey<FormBuilderState> _formKey;

          @override
          Widget build(BuildContext context) {
            return Expanded(
              child: MaterialButton(
                color: UItheme.alloyOrange,
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _formKey.currentState!.reset();
                },
              ),
            );
           }
}