class HamRadio {
  String radioName;
  String radioUuid;
  String? vfoaFrequency;
  String? vfoaModulationMode;
  String? vfoaOperatingMode;
  String? vfobFrequency;
  String? vfobModulationMode;
  String? vfobOperatingMode;
  String? vfoaFrequencyLast;
  String? vfoaModulationModeLast;
  String? vfoaOperatingModeLast;
  String? vfobFrequencyLast;
  String? vfobModulationModeLast;
  String? vfobOperatingModeLast;
  String ipAddress;
  String portNumber;
  int errors;


  HamRadio(
      {required this.radioName,
      required this.radioUuid,
      this.vfoaFrequency = '0000000000',
      this.vfoaModulationMode = '---',
      this.vfoaOperatingMode = '---',
      this.vfobFrequency = '0000000000',
      this.vfobModulationMode = '---',
      this.vfobOperatingMode = '---',
      this.vfoaFrequencyLast = '0000000000',
      this.vfoaModulationModeLast = '---',
      this.vfoaOperatingModeLast = '---',
      this.vfobFrequencyLast = '0000000000',
      this.vfobModulationModeLast = '---',
      this.vfobOperatingModeLast = '---',
      required this.ipAddress,
      required this.portNumber,
      this.errors = 0,
      });

  HamRadio.edited(
      {required this.radioName,
      required this.radioUuid,
      this.vfoaFrequency = '0000000000',
      this.vfoaModulationMode = '---',
      this.vfoaOperatingMode = '---',
      this.vfobFrequency = '0000000000',
      this.vfobModulationMode = '---',
      this.vfobOperatingMode = '---',
      required this.ipAddress,
      required this.portNumber,
      this.errors = 0,
      });

  HamRadio.fromJsonBasic(Map<String, dynamic> json)
      : radioName = json['radioName'],
        radioUuid = json['radioUuid'],
        ipAddress = json['ipAddress'],
        portNumber = json['portNumber'],
        vfoaFrequency = '0000000000',
        vfoaModulationMode = '---',
        vfoaOperatingMode = '---',
        vfobFrequency = '0000000000',
        vfobModulationMode = '---',
        vfobOperatingMode = '---',
        errors = 0;
        

  Map<String, dynamic> toJsonFull() => {
        'radioName': radioName,
        'radioUuid': radioUuid,
        'vfoaFrequency': vfoaFrequency,
        'vfoaModulationMode': vfoaModulationMode,
        'vfoaOperatingMode': vfoaOperatingMode,
        'vfobFrequency': vfobFrequency,
        'vfobModulationMode': vfobModulationMode,
        'vfobOperatingMode': vfobOperatingMode,
        'ipAddress': ipAddress,
        'portNumber': portNumber,
        'errors': errors,
      };

  Map<String, dynamic> toJson() => {
        'radioName': radioName,
        'radioUuid': radioUuid,
        'ipAddress': ipAddress,
        'portNumber': portNumber,
      };

  void vfoaSet(String frequency, String mmode) {
    vfoaFrequency = frequency;
    vfoaModulationMode = mmode;
  }

  void vfobSet(String frequency, String mmode) {
    vfobFrequency = frequency;
    vfobModulationMode = mmode;
  }
}
