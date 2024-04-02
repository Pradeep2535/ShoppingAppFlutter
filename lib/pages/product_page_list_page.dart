import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/product_details_page.dart';

class ProductPageList extends StatefulWidget {
  const ProductPageList({super.key});

  @override
  State<ProductPageList> createState() => _ProductPageListState();
}

class _ProductPageListState extends State<ProductPageList> {
  final List<String> filters = const ['All', 'Adidas', 'Bata', 'Nike'];

  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    //final size = MediaQuery.sizeOf(context);

    const border = OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(225, 225, 225, 1),
        ),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));

    return SafeArea(
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search_rounded,
                    ),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: ((context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 15),
                      label: Text(
                        filter,
                        style: const TextStyle(fontSize: 16),
                      ),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).primaryColor
                          : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ProductDetailsPage(
                                  product: products[index]);
                            }));
                          },
                          child: ProductCard(
                            title: product['title'].toString(),
                            price: double.parse(product['price'].toString()),
                            image: product['imagesUrl'] as String,
                            containerColor: index.isEven
                                ? const Color.fromRGBO(216, 240, 253, 1)
                                : const Color.fromARGB(255, 242, 241, 224),
                          ),
                        );
                      });
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProductDetailsPage(product: products[index]);
                          }));
                        },
                        child: ProductCard(
                          title: product['title'].toString(),
                          price: double.parse(product['price'].toString()),
                          image: product['imagesUrl'] as String,
                          containerColor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromARGB(255, 242, 241, 224),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
