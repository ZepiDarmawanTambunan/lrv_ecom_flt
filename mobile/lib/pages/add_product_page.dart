import 'package:flutter/material.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/providers/category_provider.dart';
import 'package:mobile/providers/image_product_provider.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController descController = TextEditingController(text: '');
  TextEditingController tagsController = TextEditingController(text: '');
  TextEditingController priceController = TextEditingController();

    @override
  void initState() {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.getcategories();
    super.initState();
  }

    @override
  void dispose() {
    // Clean up the controller
    nameController.dispose();
    descController.dispose();
    tagsController.dispose();
    priceController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print('build');
    ImageProductProvider imageProductProvider = Provider.of<ImageProductProvider>(context, listen: false);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    AppBar header(){
      return AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.close)),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text("Add Product"),
        actions: [
          IconButton(onPressed: (){
            
          }, icon: Icon(Icons.check, color: primaryColor,))
        ],
      );
    }

    Widget inputProduct({required String title, required String hintText, required TextEditingController controller, bool isNumeric = false }){
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: secondaryTextStyle.copyWith(fontSize: 13),),
            TextFormField(
              style: primaryTextStyle,
              controller: controller,
              keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget dropDownCategories(CategoryProvider categoryProvider){
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('category', style: secondaryTextStyle.copyWith(fontSize: 13),),
            DropdownButton(
              isExpanded: true,
              value: categoryProvider.selectedCategory,
              items: categoryProvider.categories.map((category) {
                return DropdownMenuItem(
                  value: category.id as int,
                  child: Text(category.name,         
                  style: TextStyle(
                    color: category.id == categoryProvider.selectedCategory ? Colors.white : Colors.black,
                  ),),
                );
              }).toList(),
              onChanged: (selectedCategory) {
                categoryProvider.selectedCategory = selectedCategory as int;
              },
            ),
          ],
        ),
      );
    }

    Widget btnUploadAndSubmit(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ElevatedButton(onPressed: (){
          imageProductProvider.selectedMultipleImage(context);
        }, child: Text('Pick Image'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
        ),
        SizedBox(width: 20,),
        ElevatedButton(onPressed: (){
          imageProductProvider.uploadImage(
            context: context,
            name: nameController.text,
            description: descController.text,
            price: priceController.text,
            tags: tagsController.text,
            categoriesId: categoryProvider.selectedCategory,
            listImagePath: imageProductProvider.listImagePath
          ).then((value){
            if(value is String){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.greenAccent,
                content: Text("$value berhasil ditambahkan", textAlign: TextAlign.center,),),
              );
              nameController.clear();
              descController.clear();
              tagsController.clear();
              priceController.clear();
              categoryProvider.selectedCategory = 1;
              categoryProvider.categories = [];
              imageProductProvider.resetImageProvider();
              Navigator.pop(context);
            }
          }).catchError((err){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: alertColor,
              content: Text("${err}", textAlign: TextAlign.center,),),
            );
          });
        }, child: Text('Submit'),),
        ],
      );
    }

    Widget content(){
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              inputProduct(title: 'name', hintText: 'your name product', controller: nameController),
              inputProduct(title: 'description', hintText: 'your desc product', controller: descController),
              inputProduct(title: 'price', hintText: 'your price product', controller: priceController, isNumeric: true),
              inputProduct(title: 'tags', hintText: 'your tags product', controller: tagsController),
              Consumer<CategoryProvider>(
                builder: (context, value, child){
                  return value.categories.length > 0 ? dropDownCategories(value) : CircularProgressIndicator();
                }
              ),
              SizedBox(height: 30,),
              btnUploadAndSubmit(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}