import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final List<String> options;

  const DetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.options,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedOption = "";
  int quantity = 1;
  int stock = 10; // Example stock limit
  late double unitPrice;

  final TextEditingController _qtyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.options.isNotEmpty) {
      selectedOption = widget.options.first;
    }

    unitPrice = double.tryParse(widget.price.replaceAll("\$", "")) ?? 0;
    _qtyController.text = quantity.toString();
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  double get totalPrice => unitPrice * quantity;

  // =========================
  // REVIEW WIDGET
  // =========================
  Widget _buildReview(String name, String comment, int rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 16,
              );
            }),
          ),
          const SizedBox(height: 4),
          Text(comment, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // =========================
      // FIXED ADD TO CART BUTTON
      // =========================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();

              print("Product: ${widget.title}");
              print("Option: $selectedOption");
              print("Quantity: $quantity");
              print("Total: $totalPrice");
            },
            child: const Text(
              "Add to Cart",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),

      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            // =========================
            // TOP IMAGE
            // =========================
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Image.asset(widget.image, fit: BoxFit.cover),
            ),

            // =========================
            // BACK BUTTON
            // =========================
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ),

            // =========================
            // SCROLLABLE DETAILS
            // =========================
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // PRICE
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // RATING
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < 4 ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "4.0 (120 reviews)",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // OPTIONS
                      const Text(
                        "Select Option",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      widget.options.isNotEmpty
                          ? Wrap(
                              spacing: 10,
                              children: widget.options.map((option) {
                                bool isSelected = selectedOption == option;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = option;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.deepPurple
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : const Text("No options available"),

                      const SizedBox(height: 25),

                      // QUANTITY
                      const Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: quantity > 1
                                  ? () {
                                      setState(() {
                                        quantity--;
                                        _qtyController.text = quantity
                                            .toString();
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.remove),
                              color: Colors.redAccent,
                            ),

                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: _qtyController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  final parsed = int.tryParse(value);
                                  if (parsed != null &&
                                      parsed > 0 &&
                                      parsed <= stock) {
                                    setState(() {
                                      quantity = parsed;
                                    });
                                  }
                                },
                              ),
                            ),

                            IconButton(
                              onPressed: quantity < stock
                                  ? () {
                                      setState(() {
                                        quantity++;
                                        _qtyController.text = quantity
                                            .toString();
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.add),
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // TOTAL
                      Text(
                        "Total: \$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // DESCRIPTION
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "This product is high quality and designed for daily use. "
                        "Comfortable, durable, and suitable for all seasons.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // REVIEWS
                      const Text(
                        "Customer Reviews",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      _buildReview("John", "Great product! Very satisfied.", 5),
                      _buildReview(
                        "Anna",
                        "Good quality but delivery was slow.",
                        4,
                      ),
                      _buildReview(
                        "Veasna",
                        "Good quality but I don't receive anything.",
                        4,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
