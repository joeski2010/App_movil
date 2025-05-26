class Ciudadano {
  final String dni;
  final String nombres;
  final String apellidos;
  // Agrega más campos según la respuesta de tu API

  Ciudadano({
    required this.dni,
    required this.nombres,
    required this.apellidos,
  });

  factory Ciudadano.fromJson(Map<String, dynamic> json) {
    return Ciudadano(
      dni: json['dni'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
    );
  }
}