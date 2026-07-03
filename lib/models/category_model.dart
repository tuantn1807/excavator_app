import '../utils/constants.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? slug;
  final String? description;
  final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    this.slug,
    this.description,
    this.image,
  });

  String get imageUrl => AppConstants.formatImageUrl(image, id: id);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? 'Không tên',
      slug: json['slug']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString() ?? json['image_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'description': description,
        'image': image,
      };
}
