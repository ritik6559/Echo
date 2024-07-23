class Blog {
  final String id;
  final String posterId;
  final String title;
  final String contet;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.contet,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });
}
