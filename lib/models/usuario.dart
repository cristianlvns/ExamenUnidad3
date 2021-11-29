class Usuario {
  int? id;
  String? nombre;
  String? apellido;

  Usuario({
    this.id,
    this.nombre,
    this.apellido,
  });
  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    nombre = json['nombre']?.toString();
    apellido = json['apellido']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['apellido'] = apellido;
    return data;
  }
}
