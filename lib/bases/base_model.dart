abstract class BaseModel<T> {
  Map<String, dynamic> toJson();
  // ignore: always_declare_return_types
  T fromJson(Map<String, dynamic> json);
}
