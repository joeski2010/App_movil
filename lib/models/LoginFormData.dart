class LoginFormData {
  final String tipoDocumento;
  final String nvNumeroDocumento;
  final String fechaEmision;
  final String? recaptchaToken;

  LoginFormData({
    required this.tipoDocumento,
    required this.nvNumeroDocumento,
    required this.fechaEmision,
    this.recaptchaToken,
  });

  // Método para convertir a Map (útil para enviar a APIs)
  Map<String, dynamic> toJson() {
    return {
      'tipoDocumento': tipoDocumento,
      'nvNumeroDocumento': nvNumeroDocumento,
      'fechaEmision': fechaEmision,
      if (recaptchaToken != null) 'recaptchaToken': recaptchaToken,
    };
  }

}