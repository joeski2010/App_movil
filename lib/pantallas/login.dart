import 'package:flutter/material.dart';
import 'package:proyecto_movil/objetos/tipo_documento.dart';

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

  @override
  void dispose() {
    _fechaController.dispose();
    _nroDocumentoController.dispose();
    super.dispose();
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
                  const SizedBox(height: 80),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                              ),
                              TextSpan(
                                text:
                                    'Por favor complete los siguientes pasos:\n',
                                style: TextStyle(
                                  fontSize: 14,
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
                                      _buildStep('1. Seleccione su tipo de documento'),
                                      _buildStep('2. Ingrese su número de documento'),
                                      _buildStep('3. Elija la fecha de emisión de su documento'),
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
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Seleccione un tipo de documento';
                                  }
                                  return null;
                                },
                                items: tiposDocumento
                                    .map((String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
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
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese el número de documento';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _fechaController,
                                readOnly: true,
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    locale: const Locale("es", "ES"),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      _fechaSeleccionada = pickedDate;
                                      _fechaController.text =
                                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Fecha de Emisión',
                                  labelText: 'Fecha de Emisión',
                                  prefixIcon: Icon(Icons.date_range),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor seleccione una fecha';
                                  }
                                  return null;
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
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    Navigator.pushNamed(context, 'home');
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
