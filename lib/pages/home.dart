import 'dart:ui';
import 'package:ecommerce_app/pages/detail_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = "All";
  bool isLoading = false; 
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

  // =========================
  // PRODUCT DATA
  // =========================
  final List<Map<String, dynamic>> allProducts = [
    {
      "image": "assets/images/1.jpg",
      "title": "T-Shirt",
      "price": "\$25",
      "category": "Clothes",
      "options": ["S", "M", "L", "XL"],
    },
    {
      "image": "assets/images/2.jpg",
      "title": "Shoes",
      "price": "\$60",
      "category": "Shoes",
      "options": ["39", "40", "41", "42"],
    },
    {
      "image": "assets/images/3.jpg",
      "title": "Bag",
      "price": "\$45",
      "category": "Bags",
      "options": ["Small", "Medium", "Large"],
    },
    {
      "image": "assets/images/4.jpg",
      "title": "Watch",
      "price": "\$80",
      "category": "Accessories",
      "options": ["Standard"],
    },
    {
      "image": "assets/images/1.jpg",
      "title": "Laptop",
      "price": "\$900",
      "category": "Electronics",
      "options": ["128GB", "256GB", "512GB"],
    },
  ];

  // =========================
  // FILTER LOGIC
  // =========================
  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> result = allProducts;

    // Category Filter
    if (selectedCategory != "All") {
      result = result
          .where((product) => product["category"] == selectedCategory)
          .toList();
    }

    // Search Filter
    if (searchQuery.isNotEmpty) {
      result = result
          .where(
            (product) => product["title"]!.toLowerCase().contains(
              searchQuery.toLowerCase(),
            ),
          )
          .toList();
    }

    return result;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            // BACKGROUND
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 154, 194, 255),
                    Color.fromARGB(255, 111, 108, 108),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // CONTENT
            SafeArea(
              child: Column(
                children: [
                  // =========================
                  // 🔥 FIXED SEARCH BAR
                  // =========================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                    child: _buildSearchBar(context),
                  ),

                  // =========================
                  // SCROLLABLE CONTENT
                  // =========================
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                        child: _buildContent(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 240, 240).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color.fromARGB(255, 132, 132, 132).withOpacity(0.25)),
                ),
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(color: Color.fromARGB(255, 210, 199, 199)),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      searchQuery = value.trim();
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for products",
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () async {
            if (isLoading) return;

            FocusScope.of(context).unfocus();

            setState(() {
              isLoading = true;
            });

            // simulate loading (API / search delay)
            await Future.delayed(const Duration(seconds: 1));

            setState(() {
              searchQuery = searchController.text.trim();
              isLoading = false;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 203, 203, 203).withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color.fromARGB(255, 2, 234, 250),
                    ),
                  )
                : const Icon(Icons.search, color: Colors.white),
          ),
        ),

      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: const [
            Icon(Icons.location_on, color: Colors.white, size: 30),
            SizedBox(width: 5),
            Text(
              "Phnom Penh, Cambodia",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        const SizedBox(height: 20),

        // BANNER
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildBanner("assets/images/1.jpg"),
                _buildBanner("assets/images/2.jpg"),
                _buildBanner("assets/images/3.jpg"),
                _buildBanner("assets/images/4.jpg"),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Category",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 55,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategory("All"),
                _buildCategory("Clothes"),
                _buildCategory("Shoes"),
                _buildCategory("Bags"),
                _buildCategory("Accessories"),
                _buildCategory("Electronics"),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Products",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 15),

        if (filteredProducts.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "No products found",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return _buildProductCard(
              product["image"],
              product["title"],
              product["price"],
              List<String>.from(product["options"] ?? []),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBanner(String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildCategory(String title) {
    bool isSelected = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.4)
              : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String image,
    String title,
    String price,
    List<String> options,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              image: image,
              title: title,
              price: price,
              options: options,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(price, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
