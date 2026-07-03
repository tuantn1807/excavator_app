import 'category_model.dart';
import '../utils/constants.dart';

class ProductModel {
  final int id;
  final int? categoryId;
  final String name;
  final String? slug;
  final String? model;
  final String? weight;
  final String? liftingCapacity;
  final String? bucketCapacity;
  final String? maxDumpHeight;
  final String? engineModel;
  final String? enginePower;
  final String? transmissionType;
  final String? tireSize;
  final String? overallDimensions;
  final String? workCycle;
  final String? maxSpeed;
  final String? gradeability;
  final String? image;
  final String? description;
  final bool isActive;
  final double price;
  final int? quantity;
  final CategoryModel? category;

  ProductModel({
    required this.id,
    this.categoryId,
    required this.name,
    this.slug,
    this.model,
    this.weight,
    this.liftingCapacity,
    this.bucketCapacity,
    this.maxDumpHeight,
    this.engineModel,
    this.enginePower,
    this.transmissionType,
    this.tireSize,
    this.overallDimensions,
    this.workCycle,
    this.maxSpeed,
    this.gradeability,
    this.image,
    this.description,
    required this.isActive,
    required this.price,
    this.quantity,
    this.category,
  });

  String get imageUrl => AppConstants.formatImageUrl(image, id: id);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      categoryId: int.tryParse(json['category_id']?.toString() ?? ''),
      name: json['name']?.toString() ?? 'Không tên',
      slug: json['slug']?.toString(),
      model: json['model']?.toString(),
      weight: json['weight']?.toString(),
      liftingCapacity: json['lifting_capacity']?.toString(),
      bucketCapacity: json['bucket_capacity']?.toString(),
      maxDumpHeight: json['max_dump_height']?.toString(),
      engineModel: json['engine_model']?.toString(),
      enginePower: json['engine_power']?.toString(),
      transmissionType: json['transmission_type']?.toString(),
      tireSize: json['tire_size']?.toString(),
      overallDimensions: json['overall_dimensions']?.toString(),
      workCycle: json['work_cycle']?.toString(),
      maxSpeed: json['max_speed']?.toString(),
      gradeability: json['gradeability']?.toString(),
      image: json['image']?.toString() ?? json['image_url']?.toString(),
      description: json['description']?.toString(),
      isActive: json['is_active'] == 1 || json['is_active'] == true || json['is_active'] == '1',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      quantity: int.tryParse(json['quantity']?.toString() ?? ''),
      category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'name': name,
        'slug': slug,
        'model': model,
        'image': image,
        'description': description,
        'is_active': isActive,
        'price': price,
        'quantity': quantity,
      };
}
