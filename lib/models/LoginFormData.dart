class LoginFormData {
  final String tipoDocumento;
  final String nroDocumento;
  final String fechaEmision;
  final String? recaptchaToken;

  LoginFormData({
    required this.tipoDocumento,
    required this.nroDocumento,
    required this.fechaEmision,
    this.recaptchaToken,
  });

  // Método para convertir a Map (útil para enviar a APIs)
  Map<String, dynamic> toJson() {
    return {
      'tipoDocumento': tipoDocumento,
      'nroDocumento': nroDocumento,
      'fechaEmision': fechaEmision,
      if (recaptchaToken != null) 'recaptchaToken': recaptchaToken,
    };
  }

}