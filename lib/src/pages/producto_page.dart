import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/provider/products_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scafoldKey = GlobalKey<ScaffoldState>();

  ProductModel product = new ProductModel();
  final productProvider = new ProductProvider();
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    final ProductModel productFromHome =
        ModalRoute.of(context).settings.arguments;
    if (productFromHome != null) {
      product = productFromHome;
    }
    return Scaffold(
      key: scafoldKey,
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
                  _crearDisponible(),
                  _crearBoton()
                ],
              )),
        ),
      ),
    );
  }

  _crearNombre() {
    return TextFormField(
      initialValue: product.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Producto",
      ),
      onSaved: (value) => product.titulo = value,
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
      initialValue: product.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: "Precio",
      ),
      onSaved: (value) => product.valor = double.parse(value),
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
      onPressed: _saving == null
          ? null
          : () {
              _submit();
            },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.deepPurple,
      label: Text("Guardar"),
      textColor: Colors.white,
      icon: Icon(Icons.save),
    );
  }

  _crearDisponible() {
    return SwitchListTile(
        title: Text('Disponible'),
        value: product.disponible,
        activeColor: Colors.deepPurple,
        onChanged: (value) {
          setState(() {
            product.disponible = value;
          });
        });
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        _saving = true;
      });
      print(product.titulo +
          "\n" +
          product.valor.toString() +
          "\n" +
          product.disponible.toString());
      if (product.id == null) {}
      productProvider.createProduct(product);
      showSnackbar("Registro guardado");
      _saving = false;
    } else {
      productProvider.updateProduct(product);
      showSnackbar("Registro actualizado");
      _saving = false;
    }
    Navigator.pop(context);
  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    scafoldKey.currentState.showSnackBar(snackbar);
  }
}
