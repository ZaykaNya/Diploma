class PageInCourse {
  final String? view;
  final String? caption;

  const PageInCourse({
    required this.view,
    required this.caption,
  });

  factory PageInCourse.fromJson(Map<String, dynamic> json) {
    return PageInCourse(
      view: json['view'],
      caption: json['caption']
    );
  }
}