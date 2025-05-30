import 'package:flutter/material.dart';
import '../models/LoginFormData.dart';
import '../services/CiudadanoService.dart';
import '../widgets/buildStep.dart';
import '../objetos/tipo_documento.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

void _showValidationResult(BuildContext context, Map<String, dynamic> response) {
  showDialog(
    context: context,
    barrierDismissible: false, // Impide cerrar el diálogo tocando fuera
    builder: (context) => WillPopScope(
      onWillPop: () async => false, // Impide retroceder con botón físico
      child: AlertDialog(
        title: Text(response['existe'] == false 
            ? 'Usuario no registrado' 
            : 'Validación fallida'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(response['message'] ?? ''),
            if (response['existe'] == false)
              const SizedBox(height: 20),
              const Text('Por favor complete su registro.'),
          ],
        ),
        actions: [
          if (response['existe'] == false)
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar diálogo
                Navigator.pushNamed(context, 'registro'); // Ir a registro
              },
              child: const Text('Registrarse'),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar diálogo
              // Permanece en la misma pantalla
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    ),
  );
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _tipoDocumento;
  DateTime? _fechaSeleccionada;
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _nroDocumentoController = TextEditingController();

  String _fechaParaMostrar = ''; // Para mostrar al usuario

  bool _isTipoDocumentoValid = false;
  bool _isNroDocumentoValid = false;
  bool _isFechaValid = false;

  String? _recaptchaToken;

  @override
  void dispose() {
    _fechaController.dispose();
    _nroDocumentoController.dispose();
    super.dispose();
  }

  Future<void> _validateForm() async {
    // Validar el formulario
    if (_formKey.currentState?.validate() ?? false) {
      // Asegurarse de que todos los campos tengan datos
      if (_tipoDocumento == null ||
          _nroDocumentoController.text.isEmpty ||
          _fechaController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, complete todos los campos.'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Salir si falta algún dato
      }

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => const Center(child: CircularProgressIndicator()),
        );
        print("Enviando datos:");
        print("Tipo documento: ${tiposDocumento.indexOf(_tipoDocumento!) + 1}");
        print("Número documento: ${_nroDocumentoController.text.trim()}");
        print("Fecha emisión: ${_fechaController.text.trim()}");

        final ciudadanoData = await CiudadanoService.validarCiudadano(
          idTipoDocumento: tiposDocumento.indexOf(_tipoDocumento!) + 1,
          nvNumeroDocumento:
              _nroDocumentoController.text.trim(), // Eliminar espacios
          fechaEmision: _fechaController.text, // Eliminar espacios
        );

        print("object");
        print(ciudadanoData);

        if (ciudadanoData) {
          Navigator.pushNamed(
            context,
            'home',
            arguments: {
              'formData': LoginFormData(
                tipoDocumento: _tipoDocumento!,
                nvNumeroDocumento: _nroDocumentoController.text,
                fechaEmision: _fechaController.text,
                recaptchaToken: _recaptchaToken,
              ),
              'ciudadanoData': ciudadanoData,
            },
          );
        } else {
          _showValidationResult(context, ciudadanoData);
          // Mostrar mensaje de error si la validación falló
          /*Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(ciudadanoData==false ? 'Validación fallida':'Error'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 3),
            ),
          );*/
        }

      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Si la validación falla, mostrar un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, corrija los errores en el formulario.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                              DropdownButtonFormField<String>(
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
                                onChanged: (value) {
                                  if ((value.isNotEmpty !=
                                      _isNroDocumentoValid)) {
                                    setState(() {
                                      _isNroDocumentoValid = value.isNotEmpty;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: TextEditingController(
                                  text: _fechaParaMostrar,
                                ), // Mostrar formato legible
                                readOnly: true,
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    // Formato para enviar al servidor (YYYY-MM-DD)
                                    String formattedDateForServer =
                                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                    // Formato para mostrar al usuario (DD/MM/YYYY)
                                    String formattedDateForDisplay =
                                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                    setState(() {
                                      _fechaController.text =
                                          formattedDateForServer; // Para enviar
                                      _fechaParaMostrar =
                                          formattedDateForDisplay; // Para mostrar
                                      _isFechaValid = true;
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Fecha de Emisión',
                                  labelText: 'Fecha de Emisión',
                                  prefixIcon: Icon(Icons.date_range),
                                ),
                                validator: (value) {
                                  _isFechaValid =
                                      value != null && value.isNotEmpty;
                                  setState(() {});
                                  return _isFechaValid
                                      ? null
                                      : 'Por favor seleccione una fecha';
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
                                onPressed: _validateForm,
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
