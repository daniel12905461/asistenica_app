class Dia {
    Dia({
        this.id,
        this.nombre,
        this.numero,
        this.estado,
        this.fecha,
        this.horaInicio,
        this.horaInicioReseso,
        this.horaFinReseso,
        this.horaFin,
        this.idFuncionarios,
        this.idMes
    });

    String? id;
    String? nombre;
    int? numero;
    dynamic estado;
    dynamic fecha;
    dynamic horaInicio;
    dynamic horaInicioReseso;
    dynamic horaFinReseso;
    dynamic horaFin;
    dynamic idFuncionarios;
    dynamic idMes;

    factory Dia.fromMap(Map<String, dynamic> json) => Dia(
        id: json["id"],
        nombre: json["nombre"],
        numero: json["numero"],
        estado: json["estado"],
        fecha: json["fecha"],
        horaInicio: json["hora_inicio"],
        horaInicioReseso: json["hora_inicio_reseso"],
        horaFinReseso: json["hora_fin_reseso"],
        horaFin: json["hora_fin"],
        idFuncionarios: json["id_funcionarios"],
        idMes: json["id_mes"]
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "numero": numero,
        "estado": estado,
        "fecha": fecha,
        "hora_inicio": horaInicio,
        "hora_inicio_reseso": horaInicioReseso,
        "hora_fin_reseso": horaFinReseso,
        "hora_fin": horaFin,
        "id_funcionarios": idFuncionarios,
        "id_mes": idMes
    };

}
