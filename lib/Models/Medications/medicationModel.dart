class MedicationModel {
  final int id;
  final String name;
  final String dose;
  final String period;
  final DateTime date;

  MedicationModel(
      {required this.id,
      required this.name,
      required this.dose,
      required this.period,
      required this.date});
}
