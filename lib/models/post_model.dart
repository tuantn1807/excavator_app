import '../utils/constants.dart';

class PostModel {
  final int id;
  final String title;
  final String? slug;
  final String content;
  final String? image;
  final bool isPublished;

  PostModel({
    required this.id,
    required this.title,
    this.slug,
    required this.content,
    this.image,
    required this.isPublished,
  });

  String get imageUrl => AppConstants.formatImageUrl(image, id: id);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? 'Không tiêu đề',
      slug: json['slug']?.toString(),
      content: json['content']?.toString() ?? '',
      image: json['image']?.toString(),
      isPublished: json['is_published'] == 1 || json['is_published'] == true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'slug': slug,
        'content': content,
        'image': image,
        'is_published': isPublished,
      };
}
