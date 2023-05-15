import 'dart:convert';

class Rol {
    Rol({
        this.id,
        this.name,
        this.displayName,
        this.enabled,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    String? displayName;
    bool? enabled;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        id: json["id"],
        name: json["name"],
        displayName: json["display_name"],
        enabled: json["enabled"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "display_name": displayName,
        "enabled": enabled,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
