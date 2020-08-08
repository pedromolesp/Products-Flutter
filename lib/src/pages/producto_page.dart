import 'package:flutter/material.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Producto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _crearNombre(),
                  _crearPrecio(),
                  _crearBoton()
                ],
              )),
        ),
      ),
    );
  }

  _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Producto",
      ),
      validator: (value) {
        if (value.length < 3) {
          return "Ingrese el nombre del producto";
        }
        return null;
      },
    );
  }

  _crearPrecio() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "Precio",
      ),
      validator: (value) {
        if (utils.isNumber(value)) {
          return null;
        } else {
          return "Solo números";
        }
      },
    );
  }

  _crearBoton() {
    return RaisedButton.icon(
      onPressed: () {
        _submit();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.deepPurple,
      label: Text("Guardar"),
      textColor: Colors.white,
      icon: Icon(Icons.save),
    );
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      print("todook");
    } else {
      return;
    }
  }
}
