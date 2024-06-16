import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/includes/rooms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'info.dart';
//import 'package:indoor_navigation/pages/info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final textDisplay = GoogleFonts.lato(
    color: MyColors.textColorwhite,
    fontSize: 19.0,
    fontWeight: FontWeight.bold,
  );
  final textDisplaySmall = GoogleFonts.lato(
    color: MyColors.textColorwhite,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );
  final ScrollController _scrollController = ScrollController();
  final items = <Widget>[
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(
      Icons.camera_indoor,
      size: 30,
    ),
    const Icon(
      Icons.my_location,
      size: 30,
    )
  ];

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Adjusted height
        child: AppBar(
          title: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Current Location",
                  style: GoogleFonts.lato(
                      fontSize: 16, color: MyColors.primaryColor),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Edlawit')));
              },
              icon: Icon(
                Icons.person,
                size: 30.0,
                color: MyColors.textColorwhite,
              ),
            )
          ],
          backgroundColor: MyColors.backgroundColor,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: MyColors.textColorwhite,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: MyColors.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Text(
                      'edlsiraw@mail.com',
                      style: TextStyle(
                        fontSize: 11,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 30.0,
                    child: Icon(
                      Icons.account_circle,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home'),
            _buildDrawerItem(Icons.map, 'Map View'),
            _buildDrawerItem(Icons.settings, 'Settings'),
            _buildDrawerItem(Icons.info, 'About Us'),
            _buildDrawerItem(Icons.contact_page_outlined, 'Contact Us'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome To",
                style: GoogleFonts.lato(
                    fontSize: 24, color: MyColors.primaryColor)),
            Text("SSGI Office Navigation",
                style: GoogleFonts.lato(
                    fontSize: 24, color: MyColors.primaryColor)),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: MyColors.tertiaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: MyColors.tertiaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (query) {
                        _performSearch(query);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                      style: textDisplaySmall,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.search,
                      color: MyColors.textColorwhite,
                    ),
                    onTap: () {
                      _performSearch(_searchController.text);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Rooms(
                      roomrsicon: '🚽',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Home(), // Navigate to FloorDetail screen
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text("Rest Room",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Rooms(
                      roomrsicon: '🥤',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text("Lounge", style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Rooms(
                      roomrsicon: '📑',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Home(), // Navigate to FloorDetail screen
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text("Meeting",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Rooms(
                      roomrsicon: '📚',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Home(), // Navigate to FloorDetail screen
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text("Library",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Text(
                "Department Categories",
                style: textDisplay,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 4.0),
              child: SizedBox(
                height: 300,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Info()),
                          );
                        },
                        child: Container(
                          height: 200,
                          width: 250,
                          color: MyColors.tertiaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: Container(
                          height: 200,
                          width: 250,
                          color: MyColors.tertiaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: Container(
                          height: 200,
                          width: 250,
                          color: MyColors.tertiaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: Container(
                          height: 200,
                          width: 250,
                          color: MyColors.tertiaryColor,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: MyColors.primaryColorBg,
                        ),
                        onPressed: _scrollLeft,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Camera',
            ),
          ],
          backgroundColor: MyColors.tertiaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: MyColors.primaryColorBg,
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  void _performSearch(String query) {
    print('Searching for: $query');
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, color: MyColors.primaryColor),
        title: Text(
          title,
          style: GoogleFonts.lato(fontSize: 16, color: MyColors.primaryColor),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
