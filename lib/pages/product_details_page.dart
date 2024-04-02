import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added successfully'),
        ),
      );
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'company': widget.product['company'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'sizes': selectedSize,
        'imagesUrl': widget.product['imagesUrl'],
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a size'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final screenratiovalue = screenSize.height / 5.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(children: [
        Container(
          width: screenSize.width,
          height: 3 * screenratiovalue,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                widget.product['imagesUrl'] as String,
                height: 2 * screenratiovalue,
              ),
            ),
            const Spacer(flex: 2),
          ]),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(236, 239, 241, 1),
                borderRadius: BorderRadius.circular(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text('Rs ${widget.product['price'].toString()}',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['sizes'] as List<int>)[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                              backgroundColor: selectedSize == size
                                  ? Theme.of(context).primaryColor
                                  : const Color.fromRGBO(245, 247, 249, 1),
                              label: Text(
                                size.toString(),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    fixedSize: const Size(300, 50),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
