

class Profiling {
  final int? id;
  final int? date;
  final String? title;
  final int? value;

  Profiling({
    this.id,
    this.date,
    this.title,
    this.value
  });

  Map<String, dynamic> toMap() => {
    'date': this.date,
    'title': this.title,
    'value': this.value
  };
}