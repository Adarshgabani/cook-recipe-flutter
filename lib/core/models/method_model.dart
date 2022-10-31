class MethodModel {
  final String method;
  final String? imageUrl;

  MethodModel({required this.method, required this.imageUrl});
  MethodModel.fromJson(Map<String, dynamic> json)
      : method = json['methodText'],
        imageUrl = json['imageUrl'];
  Map<String, dynamic> toJson() => {
        'methodText': method,
        'imageUrl': imageUrl,
      };
  @override
  int get hashCode => method.hashCode ^ imageUrl.hashCode;

  @override
  bool operator ==(Object other) {
    return other is MethodModel && other.hashCode == hashCode;
  }
}
