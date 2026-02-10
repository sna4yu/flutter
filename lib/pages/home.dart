import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 28, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Location ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 34, 41, 47),
                  size: 34,
                ),
                SizedBox(width: 5),
                Text(
                  "Phnom Penh, Cambodia",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(right: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(141, 97, 97, 97),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for products",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 41, 47),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
