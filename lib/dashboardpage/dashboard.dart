import 'package:flutter/material.dart';
import 'package:trimusckcalc/loginpage/login.dart';
import 'package:trimusckcalc/mathpage/calculator.dart';
import 'package:trimusckcalc/mathpage/oddeven.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.calculate, "label": "Calculator", "route": CalculatorPage()},
    {"icon": Icons.filter_1, "label": "Odd Even", "route": OddEvenPage()},
    {"icon": Icons.group, "label": "Member List"},
    {
      "icon": Icons.logout,
      "label": "Logout",
      "route": null, // Logout tidak punya route, kita akan tangani manual
    },
  ];
  List<Map<String, dynamic>> filteredMenuItems = [];

  @override
  void initState() {
    super.initState();
    filteredMenuItems = List.from(menuItems);
  }

  void _filterMenu(String query) {
    setState(() {
      filteredMenuItems = menuItems
          .where((item) =>
              item["label"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildMenuSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Color.fromARGB(255, 12, 22, 154)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "\nWelcome,\nTriMusk-Calc",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white, size: 28),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _searchController,
        onChanged: _filterMenu,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 28),
          hintText: "Search...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Text(
            "Menu",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.3,
            ),
            itemCount: filteredMenuItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (filteredMenuItems[index]["label"] == "Logout") {
                    _logout(context);
                  } else if (filteredMenuItems[index]["route"] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => filteredMenuItems[index]["route"],
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        filteredMenuItems[index]["icon"],
                        size: 35,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        filteredMenuItems[index]["label"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
