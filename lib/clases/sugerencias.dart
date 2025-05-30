import 'package:flutter/material.dart';


class SuggestionItem {
  final String title;
  final String subtitle;
  final IconData icon;

  SuggestionItem(this.title, this.subtitle, this.icon);
}

class CustomAutocomplete extends StatelessWidget {
  const CustomAutocomplete({super.key});

  static final List<SuggestionItem> options = [
    SuggestionItem('RENIEC', 'Realiza trámites de duplicado y renovación de DNI', Icons.flutter_dash),
    SuggestionItem('MIGRACIONES', 'Realiza trámites de pasaporte y carnet de extranjeria', Icons.cloud),
    SuggestionItem('SUNAT', 'Realiza trámites de tributación', Icons.code),
    SuggestionItem('BANCO DE LA NACIÓN', 'Realiza trámites de pago de tasas', Icons.web),
  ];

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<SuggestionItem>(
      displayStringForOption: (SuggestionItem option) => option.title,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) return const Iterable<SuggestionItem>.empty();
        return options.where((item) =>
            item.title.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (SuggestionItem selected) {
        debugPrint('Seleccionado: ${selected.title}');
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            labelText: 'Buscar entidades',
            border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
           //borderSide: BorderSide.none, // Elimina el borde si lo deseas

            ),
            prefixIcon: Icon(Icons.search),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          elevation: 4,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: options.map((item) {
              return ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                onTap: () => onSelected(item),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}