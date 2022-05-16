class Page {
  final String? view;
  final String? caption;

  const Page({
    required this.view,
    required this.caption,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      view: json['view'],
      caption: json['caption']
    );
  }
}