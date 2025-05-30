import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_movil/models/Ciudadano.dart';
import 'package:proyecto_movil/objetos/tipo_documento.dart';
import 'package:proyecto_movil/widgets/buildStep.dart';
import 'package:proyecto_movil/models/LoginFormData.dart';

Future<Ciudadano> fetchCiudadano(String dni) async {
  try {
    final response = await http.get(
      Uri.parse('https://localhost:7178/api/Ciudadano/1'),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type',
      },
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return Ciudadano.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar los datos del ciudadano');
    }
  } catch (e) {
    print(e);
    throw Exception('Error al cargar los datos del ciudadano');
  }
}

Future<Ciudadano> validarCiudadano() async {
  const String url = 'https://localhost:7178/api/ciudadano/validar';
  
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'idTipoDocumento': 1,          // Ejemplo: 1 para DNI
        'nvNumeroDocumento': '12345678', // Número de documento
        'fechaEmision': '2024-01-15',   // Fecha en formato YYYY-MM-DD
      }),
    );

    if (response.statusCode == 200) {
      
      print('Respuesta exitosa: ${response.body}');
      return Ciudadano.fromJson(json.decode(response.body));
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Error al cargar los datos del ciudadano');
    }
  } catch (e) {
    print('Excepción: $e');
    throw Exception('Error al cargar los datos del ciudadano');
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _tipoDocumento;
  DateTime? _fechaSeleccionada;
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _nroDocumentoController = TextEditingController();

  bool _isTipoDocumentoValid = false;
  bool _isNroDocumentoValid = false;
  bool _isFechaValid = false;

  String? _recaptchaToken;
  bool _isCaptchaVerified = false;

  @override
  void dispose() {
    _fechaController.dispose();
    _nroDocumentoController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      final formData = LoginFormData(
        tipoDocumento: _tipoDocumento!,
        nvNumeroDocumento: _nroDocumentoController.text,
        fechaEmision: _fechaController.text,
        recaptchaToken: _recaptchaToken,
      );
      Navigator.pushNamed(context, 'home', arguments: formData);
    }
    return isValid;
  }

  Widget _buildStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(9, 18, 192, 1),
                    Color.fromRGBO(9, 18, 192, 1),
                  ],
                ),
              ),
              width: double.infinity,
              height: size.height * 0.2,
              child: Stack(
                children: [
                  Positioned(
                    top: 90,
                    left: 30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromRGBO(255, 255, 255, 0.05),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '¡Hola!\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.8,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Por favor, registra tu número de documento de identidad antes de ingresar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 5),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Ingrese sus datos\n',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Por favor complete los siguientes pasos:\n',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildStep(
                                        '1. Seleccione su tipo de documento',
                                        isValid: _isTipoDocumentoValid,
                                      ),
                                      buildStep(
                                        '2. Ingrese su número de documento',
                                        isValid: _isNroDocumentoValid,
                                      ),
                                      buildStep(
                                        '3. Elija la fecha de emisión de su documento',
                                        isValid: _isFechaValid,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Valida cuando se hace clic en cualquier parte fuera del dropdown
                                  _formKey.currentState?.validate();
                                },
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    hintText: 'Tipo de Documento',
                                    labelText: 'Tipo de Documento',
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                  value: _tipoDocumento,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _tipoDocumento = newValue;
                                      _isTipoDocumentoValid =
                                          newValue?.isNotEmpty ?? false;
                                    });
                                  },
                                  validator: (value) {
                                    _isTipoDocumentoValid =
                                        value != null && value.isNotEmpty;
                                    setState(() {});
                                    return _isTipoDocumentoValid
                                        ? null
                                        : 'Seleccione un tipo de documento';
                                  },
                                  items:
                                      tiposDocumento
                                          .map(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ),
                                          )
                                          .toList(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _nroDocumentoController,
                                decoration: const InputDecoration(
                                  hintText: 'Nro de Documento',
                                  labelText: 'Nro de Documento',
                                  prefixIcon: Icon(Icons.search),
                                ),
                                validator: (value) {
                                  _isNroDocumentoValid =
                                      value != null && value.isNotEmpty;
                                  setState(() {});
                                  return _isNroDocumentoValid
                                      ? null
                                      : 'Ingrese el número de documento';
                                },
                                // Actualización en tiempo real (opcional)
                                onChanged: (value) {
                                  // Solo actualiza el estado si el valor cambió de vacío a no vacío (o viceversa)
                                  if ((value.isNotEmpty !=
                                      _isNroDocumentoValid)) {
                                    setState(() {
                                      _isNroDocumentoValid = value.isNotEmpty;
                                    });
                                  }
                                },
                                // Opcional: Validar al perder el foco
                                onFieldSubmitted:
                                    (_) => _formKey.currentState?.validate(),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _fechaController,
                                readOnly: true,
                                onTap: () async {
                                  FocusScope.of(
                                    context,
                                  ).unfocus(); // Cierra el teclado si está abierto
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  ).then((date) {
                                    // Usa then para evitar setState anidados
                                    if (date != null) {
                                      _fechaController.text =
                                          "${date.day}/${date.month}/${date.year}";
                                      _isFechaValid = true;
                                      if (mounted) setState(() {});
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Fecha de Emisión',
                                  labelText: 'Fecha de Emisión',
                                  prefixIcon: Icon(Icons.date_range),
                                ),
                                validator: (value) {
                                  _isFechaValid =
                                      value != null && value.isNotEmpty;
                                  setState(() {}); // Actualiza el estado
                                  return _isFechaValid
                                      ? null
                                      : 'Por favor seleccione una fecha';
                                  ;
                                },
                                // Opcional: Validar al perder el foco
                                onFieldSubmitted: (_) {
                                  setState(() {
                                    _isFechaValid =
                                        _fechaController.text.isNotEmpty;
                                  });
                                },
                              ),

                              const SizedBox(height: 30),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                disabledColor: Colors.grey,
                                elevation: 0,
                                color: const Color.fromRGBO(9, 18, 192, 1),
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    try {
                                      // Muestra un indicador de carga
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder:
                                            (context) => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                      );

                                      // Obtiene los datos del ciudadano
                                      final ciudadanoData =
                                          await validarCiudadano(
                                            /*_nroDocumentoController.text,*/
                                          );
                                      //print(ciudadanoData);
                                      // Cierra el diálogo de carga
                                      Navigator.of(context).pop();

                                      // Navega a la siguiente pantalla con los datos
                                      Navigator.pushNamed(
                                        context,
                                        'home',
                                        arguments: {
                                          'formData': LoginFormData(
                                            tipoDocumento: _tipoDocumento!,
                                            nvNumeroDocumento:
                                                _nroDocumentoController.text,
                                            fechaEmision: _fechaController.text,
                                            recaptchaToken: _recaptchaToken,
                                          ),
                                          'ciudadanoData': ciudadanoData,
                                        },
                                      );
                                    } catch (e) {
                                      // Cierra el diálogo de carga si hay error
                                      Navigator.of(context).pop();

                                      // Muestra un mensaje de error
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Errorh: ${e.toString()}',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 80,
                                    vertical: 15,
                                  ),
                                  child: const Text(
                                    'Ingresar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
