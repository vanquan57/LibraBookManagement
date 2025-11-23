import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/author/author.dart';
import 'package:mobile/share/data/models/publisher/publisher.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  final int id;
  @JsonKey(name: 'author_id')
  final int authorId;
  @JsonKey(name: 'publisher_id')
  final int? publisherId;
  final String name;
  final String? slug;
  @JsonKey(name: 'mini_description')
  final String? miniDescription;
  @JsonKey(name: 'details_description')
  final String? detailsDescription;
  @JsonKey(name: 'publication_date')
  final String? publicationDate;
  final int? quantity;
  final String? size;
  final int? page;
  @JsonKey(name: 'cover_type')
  final int? coverType;
  final int? views;
  @JsonKey(name: 'borrowing_number')
  final int? borrowingNumber;
  final String image;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'feedbacks_count')
  final int feedbacksCount;
  @JsonKey(name: 'average_star')
  final int averageStar;
  final Author? author;
  final Publisher? publisher;

  Book({
    required this.id,
    required this.authorId,
    this.publisherId,
    required this.name,
    this.slug,
    this.miniDescription,
    this.detailsDescription,
    this.publicationDate,
    this.quantity,
    this.size,
    this.page,
    this.coverType,
    this.views,
    this.borrowingNumber,
    required this.image,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    required this.feedbacksCount,
    required this.averageStar,
    this.author,
    this.publisher,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
