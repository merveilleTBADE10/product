import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterpanier/mysql_connect/mysql.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Projet'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Produits'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProductList()),
                // );
              },
            ),
            ListTile(
              title: Text('Registre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterList()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Bienvenue dans Ma Boutique'),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  ProductList({required this.products});
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> _products = [];
  void _deleteData(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent, content: Text("Data Deleted")));
  }

  void _addItem() async {
    // Ouvrez la page AddProduct pour ajouter un nouvel élément
    Product? newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProduct()),
    );

    // Si un nouveau produit est ajouté, mettez à jour l'état de la liste des produits
    if (newProduct != null) {
      setState(() {
        _products.add(newProduct);
      });
    }
  }

  void _refreshProducts() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _products = data.cast<Product>();
    });
  }

  void initState() {
    super.initState();
    _refreshProducts();
    print("..number of items ${_products.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF674AEF),
        iconTheme: IconThemeData(color: Colors.white),
        // leading en blanc
        title: Text(
          "Liste des poduits",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                _refreshProducts();
              },
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      // la liste des produits saffiche
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
                title: Text(widget.products[index]['name']),
                subtitle: Text('Prix: ${widget.products[index]['unitPrice']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        _deleteData(widget.products[index]['id']);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _addItem, // Appeler la méthode _addItem() lorsqu'on appuie sur le bouton
        child: Icon(Icons.add),
      ),
    );
  }
}

// list des registres
class RegisterList extends StatefulWidget {
  @override
  _RegisterListState createState() => _RegisterListState();
}

class _RegisterListState extends State<RegisterList> {
  List<RegisterEntry> registerEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF674AEF),
        iconTheme: IconThemeData(color: Colors.white),
        // leading en blanc
        title: Text(
          "Liste des registre",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.info,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: registerEntries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
                title: Text(registerEntries[index].product),
                subtitle: Text(
                  'Date: ${registerEntries[index].date}, Prix unitaire: ${registerEntries[index].unitPrice}',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEntry();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addEntry() async {
    RegisterEntry? newEntry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRegisterEntry()),
    );

    if (newEntry != null) {
      setState(() {
        registerEntries.add(newEntry);
      });
    }
  }
}

// details du produit
class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Product _editedProduct;

  @override
  void initState() {
    super.initState();
    _editedProduct = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF674AEF),
        iconTheme: IconThemeData(color: Colors.white),
        // leading en blanc
        title: Text(
          'Détails du Produit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.featured_play_list_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
                title: Text('Nom: ${_editedProduct.name}'),
                subtitle: Text(
                  'Prix unitaire: ${_editedProduct.unitPrice}',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {
                          // pop up
                          ;
                        },
                        child: Icon(
                          Icons.visibility,
                          color: Colors.blue,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    // icon edit
                    GestureDetector(
                        onTap: () {
                          _editProduct();
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.amber,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    // icone deletr
                    GestureDetector(
                        onTap: () {
                          _deleteProduct();
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            ),

            // Text('Prix en gros: ${_editedProduct.wholesalePrice}'),
            // Text('Quantité en gros: ${_editedProduct.wholesaleQuantity}'),
            // Text('Quantité disponible: ${_editedProduct.availableQuantity}'),
          ],
        ),
      ),
    );
  }

  // detail dun produit
  // Widget detail (){
  //   return AlertDialog(
  //     title: Text("test"),
  // content: Text('Prix en gros: ${_editedProduct.wholesalePrice}'),
  //           // Text('Quantité en gros: ${_editedProduct.wholesaleQuantity}'),
  //           // Text('Quantité disponible: ${_editedProduct.availableQuantity}'),
  //   );
  // }
// editer un produit
  void _editProduct() async {
    Product? editedProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProduct(_editedProduct)),
    );

    if (editedProduct != null) {
      setState(() {
        _editedProduct = editedProduct;
      });
    }
  }

  void _deleteProduct() {
    // Suppression logique du produit ici
    // Vous pouvez marquer le produit comme supprimé dans votre modèle de données
    Navigator.pop(context, true);
  }
}

// ajouter un produit
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _wholesalePriceController =
      TextEditingController();
  final TextEditingController _wholesaleQuantityController =
      TextEditingController();
  final TextEditingController _availableQuantityController =
      TextEditingController();

  List<Map<String, dynamic>> _products = [];
  bool _isloading = true;
  int? id;

  void _refreshProducts() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _products = data;
      _isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshProducts();
    print("..number of items ${_products.length}");
  }

  //add products
  //add products
  Future<void> _addItem() async {
    await SQLHelper.createItem(
      _nameController.text,
      int.parse(_unitPriceController.text), // Convertissez le texte en entier
      int.parse(
          _wholesalePriceController.text), // Convertissez le texte en entier
      int.parse(
          _wholesaleQuantityController.text), // Convertissez le texte en entier
      int.parse(
          _availableQuantityController.text), // Convertissez le texte en entier
    );
    _refreshProducts();
    print("..number if items ${_products.length}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF674AEF),
        iconTheme: IconThemeData(color: Colors.white),
        // leading en blanc
        title: Text(
          "Produit",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            ProductList(products: _products))));
              },
              child: Icon(
                Icons.featured_play_list_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag,
                    size: 90,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Ajouter vos produit !!!"),
                  SizedBox(
                    height: 20,
                  ),
                  // champ Entrez le nom du produit
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Entrez le nom du produit",
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.local_drink,
                          color: Colors.green,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un nom de produit';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // champ Entrez le prix unitaire
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _unitPriceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Entrez le prix unitaire",
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.attach_money,
                          color: Colors.blueAccent,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un prix unitaire';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // champ Entrez le prix en gros
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _wholesalePriceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Entrez le prix en gros",
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.store,
                          color: Colors.amber,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un prix en gros';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // champ Entrez une quantité en gros
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _wholesaleQuantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Entrez une quantité en gros",
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.local_grocery_store,
                          color: Colors.deepOrange,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une quantité en gros';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // champ Entrez une quantité disponibl
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _availableQuantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Entrez une quantité disponible",
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.inventory_2,
                          color: Colors.purple,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une quantité disponible';
                        }
                        return null;
                      },
                    ),
                  ),
                  // bouton pour ajouter le produit
                  SizedBox(height: 16),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 50, left: 50, bottom: 20),
                    child: Material(
                      color: Color(0XFF674AEF),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () async {
                          if (id == null) {
                            await _addItem();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductList(products: _products)));
                          }
                          if (id != null) {
                            // await _updateItem(id);
                          }
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Text(
                              "Ajouter",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// methode pour sauvegarder les produits create
//  void _saveProduct() async {
//   if (_formKey.currentState!.validate()) {
//     String name = _nameController.text;
//     double unitPrice = double.parse(_unitPriceController.text);
//     double wholesalePrice = double.parse(_wholesalePriceController.text);
//     double wholesaleQuantity =
//         double.parse(_wholesaleQuantityController.text);
//     double availableQuantity =
//         double.parse(_availableQuantityController.text);

//     Product newProduct = Product(
//       name: name,
//       unitPrice: unitPrice,
//       wholesalePrice: wholesalePrice,
//       wholesaleQuantity: wholesaleQuantity,
//       availableQuantity: availableQuantity,
//     );

//     try {
//       await DatabaseService().openConnection();
//       await DatabaseService().saveProduct(newProduct);
//       await DatabaseService().closeConnection();
//       Navigator.pop(context, newProduct);
//     } catch (e) {
//       print('Error saving product: $e');
//       // Handle error appropriately
//     }
//   }
// }
}

// modifier produit

class EditProduct extends StatefulWidget {
  final Product product;

  EditProduct(this.product);

  @override
  _EditProductState createState() => _EditProductState();
}

// editer un produit
class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _unitPriceController;
  late TextEditingController _wholesalePriceController;
  late TextEditingController _wholesaleQuantityController;
  late TextEditingController _availableQuantityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _unitPriceController =
        TextEditingController(text: widget.product.unitPrice.toString());
    _wholesalePriceController =
        TextEditingController(text: widget.product.wholesalePrice.toString());
    _wholesaleQuantityController = TextEditingController(
        text: widget.product.wholesaleQuantity.toString());
    _availableQuantityController = TextEditingController(
        text: widget.product.availableQuantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF674AEF),
        iconTheme: IconThemeData(color: Colors.white),
        // leading en blanc
        title: Text(
          'Modifier le Produit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.featured_play_list_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag,
                    size: 90,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Modifier votre produit !!!"),
                  SizedBox(
                    height: 20,
                  ),
                  // modifier nom du roduit
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.local_drink,
                          color: Colors.green,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un nom de produit';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // modifier le prix unitaier
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _unitPriceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.attach_money,
                          color: Colors.blueAccent,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un prix unitaire';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // modifier le prix en gros
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _wholesalePriceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.store,
                          color: Colors.amber,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un prix en gros';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // modifier quantité en gros
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _wholesaleQuantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.local_grocery_store,
                          color: Colors.deepOrange,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une quantité en gros';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //  modifier la quantité disponible
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _availableQuantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                        icon: Icon(
                          Icons.inventory_2,
                          color: Colors.purple,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une quantité disponible';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 50, left: 50, bottom: 20),
                    child: Material(
                      color: Color(0XFF674AEF),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          // la methode pour modifier le produit
                          _saveProduct();
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Text(
                              "Enregistrer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      double unitPrice = double.parse(_unitPriceController.text);
      double wholesalePrice = double.parse(_wholesalePriceController.text);
      double wholesaleQuantity =
          double.parse(_wholesaleQuantityController.text);
      double availableQuantity =
          double.parse(_availableQuantityController.text);

      Product updatedProduct = Product(
        name: name,
        unitPrice: unitPrice,
        wholesalePrice: wholesalePrice,
        wholesaleQuantity: wholesaleQuantity,
        availableQuantity: availableQuantity,
      );

      Navigator.pop(context, updatedProduct);
    }
  }
}

class AddRegisterEntry extends StatefulWidget {
  @override
  _AddRegisterEntryState createState() => _AddRegisterEntryState();
}

class _AddRegisterEntryState extends State<AddRegisterEntry> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _remainingQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF674AEF),
        iconTheme: IconThemeData(color: Colors.white),
        // leading en blanc
        title: Text(
          "Registre",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: ((context) => ProductList(products: _products))));
              },
              child: Icon(
                Icons.featured_play_list_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Icon(
                  Icons.shopping_bag,
                  size: 90,
                  color: Colors.blue,
                ),
                Text("Ajouter vos produit au registre !!!"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: "Entrez la date",
                      suffixIcon: Icon(Icons.edit),
                      icon: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.date_range,
                          color: Colors.deepOrange,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une date';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _productController,
                    decoration: InputDecoration(
                      hintText: "Entrez le produit associé",
                      suffixIcon: Icon(Icons.edit),
                      icon: Icon(
                        Icons.shopping_bag,
                        color: Colors.green,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un produit associé';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Quantité du Produit",
                      suffixIcon: Icon(Icons.edit),
                      icon: Icon(
                        Icons.production_quantity_limits,
                        color: Colors.deepPurple,
                      ),
                      border: InputBorder.none,
                    ),
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une quantité';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _unitPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Prix unitaire",
                      suffixIcon: Icon(Icons.edit),
                      icon: Icon(
                        Icons.attach_money,
                        color: Colors.red,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un prix unitaire';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _totalPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Prix total",
                      suffixIcon: Icon(Icons.edit),
                      icon: Icon(
                        Icons.price_change,
                        color: Colors.blue,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un prix total';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _remainingQuantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Quantité restante",
                      suffixIcon: Icon(Icons.edit),
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.amber,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une quantité restante';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                // bouton pour ajouter le produit
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 50, left: 50, bottom: 20),
                  child: Material(
                    color: Color(0XFF674AEF),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        // la methode pour ajouter le produit
                        _saveEntry();
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Text(
                            "Ajouter",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      String date = _dateController.text;
      String product = _productController.text;
      double quantity = double.parse(_quantityController.text);
      double unitPrice = double.parse(_unitPriceController.text);
      double totalPrice = double.parse(_totalPriceController.text);
      double remainingQuantity =
          double.parse(_remainingQuantityController.text);

      RegisterEntry newEntry = RegisterEntry(
        date: date,
        product: product,
        quantity: quantity,
        unitPrice: unitPrice,
        totalPrice: totalPrice,
        remainingQuantity: remainingQuantity,
      );

      Navigator.pop(context, newEntry);
    }
  }
}

class Product {
  String name;
  double unitPrice;
  double wholesalePrice;
  double wholesaleQuantity;
  double availableQuantity;

  Product({
    required this.name,
    required this.unitPrice,
    required this.wholesalePrice,
    required this.wholesaleQuantity,
    required this.availableQuantity,
  });
}

class RegisterEntry {
  String date;
  String product;
  double quantity;
  double unitPrice;
  double totalPrice;
  double remainingQuantity;

  RegisterEntry({
    required this.date,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.remainingQuantity,
  });
}
