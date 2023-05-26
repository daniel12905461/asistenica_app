class Dia {
    Dia({
        this.id,
        this.nombre,
        this.numero,
        this.estado,
        this.fecha,
        this.idFuncionarios,
        this.idMes
    });

    String? id;
    String? nombre;
    int? numero;
    dynamic estado;
    dynamic fecha;
    dynamic idFuncionarios;
    dynamic idMes;

    factory Dia.fromMap(Map<String, dynamic> json) => Dia(
        id: json["id"],
        nombre: json["nombre"],
        numero: json["numero"],
        estado: json["estado"],
        fecha: json["fecha"],
        idFuncionarios: json["id_funcionarios"],
        idMes: json["id_mes"]
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "numero": numero,
        "estado": estado,
        "fecha": fecha,
        "id_funcionarios": idFuncionarios,
        "id_mes": idMes
    };

}
