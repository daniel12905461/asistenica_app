import 'dart:convert';

class User {
    User({
        this.id,
        this.nombres,
        this.apellidos,
        this.ci,
        this.email,
        this.username,
        this.password,
        // this.memberId
    });

    int? id;
    String? nombres;
    String? apellidos;
    String? ci;
    String? email;
    String? username;
    String? password;
    // dynamic memberId;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        ci: json["ci"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        // memberId: json["member_id"]
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombres": nombres,
        "apellidos": apellidos,
        "ci": ci,
        "email": email,
        "username": username,
        "password": password,
        // "member_id": memberId
    };
}
