class Ciudadano {
  final int idCiudadano;
  final int idTipoDocumento;
  final String nvNumeroDocumento; // nvNumeroDocumento
  final DateTime fechaEmision;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String ubigeo;
  final String direccion;
  final String email;
  final String telefono;
  // Agrega más campos según la respuesta de tu API

  Ciudadano({
    required this.idCiudadano,
    required this.idTipoDocumento,
    required this.nvNumeroDocumento,
    required this.fechaEmision,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.ubigeo,
    required this.direccion,
    required this.email,
    required this.telefono,
  });

  factory Ciudadano.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    
    return Ciudadano(
      idCiudadano: data['idCiudadano'] as int,
      idTipoDocumento: data['idTipoDocumento'] as int,
      nvNumeroDocumento: data['nvNumeroDocumento'] as String,
      fechaEmision: DateTime.parse(data['dFechaEmision'] as String),
      nombres: data['nvNombres'] as String,
      apellidoPaterno: data['nvApePaterno'] as String,
      apellidoMaterno: data['nvApeMaterno'] as String,
      ubigeo: data['nvUbigeo'] as String,
      direccion: data['nvDireccion'] as String,
      email: data['nvEmail'] as String,
      telefono: data['nvTelefono'] as String,
    );
  }
}