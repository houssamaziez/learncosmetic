class PromotionBanner {
  final String title;
  final String subtitle;
  final String image;

  PromotionBanner({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {'title': title, 'subtitle': subtitle, 'image': image};
  }

  factory PromotionBanner.fromJson(Map<String, dynamic> json) {
    return PromotionBanner(
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
    );
  }
}
