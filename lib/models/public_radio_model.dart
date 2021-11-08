class PublicHamRadio {
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

  PublicHamRadio({
    required this.radioName,
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
  });

  PublicHamRadio.fromJson(Map<String, dynamic> json)
      : radioName = json['radioName'],
        radioUuid = json['radioUuid'],
        vfoaFrequency = json['vfoaFrequency'],
        vfoaModulationMode = json['vfoaModulationMode'],
        vfoaOperatingMode = json['vfoaOperatingMode'],
        vfobFrequency = json['vfobFrequency'],
        vfobModulationMode = json['vfobModulationMode'],
        vfobOperatingMode = json['vfobOperatingMode'];

  Map<String, dynamic> toJson() => {
        'radioName': radioName,
        'radioUuid': radioUuid,
        'vfoaFrequency': vfoaFrequency,
        'vfoaModulationMode': vfoaModulationMode,
        'vfoaOperatingMode': vfoaOperatingMode,
        'vfobFrequency': vfobFrequency,
        'vfobModulationMode': vfobModulationMode,
        'vfobOperatingMode': vfobOperatingMode,
      };
}
