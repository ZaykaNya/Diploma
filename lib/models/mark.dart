class Mark {
  final String? mark;

  const Mark({
    required this.mark,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      mark: json['mark'],
    );
  }
}