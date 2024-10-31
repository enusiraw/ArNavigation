import 'package:ar_navigation/includes/colors.dart';
import 'package:ar_navigation/includes/functions%5D/search_service.dart';
import 'package:ar_navigation/includes/rooms.dart';
import 'package:ar_navigation/pages/category_list.dart';
import 'package:ar_navigation/pages/profile.dart';
import 'package:ar_navigation/services/camera_service.dart';
import 'package:ar_navigation/services/location_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//import 'package:'
import 'info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<DocumentSnapshot> _searchResults = [];
  final SearchService _searchService = SearchService();
  late LocationService _locationService;
  int _currentIndex = 0;

  final textDisplay = GoogleFonts.josefinSans(
    color: const Color.fromARGB(255, 52, 51, 51),
    fontSize: 19.0,
    fontWeight: FontWeight.bold,
  );
  final textDisplaySmall = GoogleFonts.lato(
    color: MyColors.textColorwhite,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

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

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _locationService = Provider.of<LocationService>(context, listen: false);
    _initializeLocationService();
  }

  void _initializeLocationService() async {
    await _locationService.checkAndRequestLocation(context);
  }

  void _searchDepartments() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      final results = await _searchService.searchDepartments(query);
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _locationService,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              title: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ' ${LocationService.currentAddress}',
                      style: GoogleFonts.lato(
                          fontSize: 16, color: const Color.fromARGB(255, 52, 51, 51)),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    size: 30.0,
                    color: MyColors.primaryColorBg,
                  ),
                )
              ],
              backgroundColor: Colors.white,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: MyColors.primaryColorBg,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ),
          ),
          drawer: Drawer(
            backgroundColor: MyColors.backgroundColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: const Text('User Name'),
                  accountEmail: const Text('user@example.com'),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                  ),
                ),
                _buildDrawerItem(
                  Icons.home,
                  'Home',
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                _buildDrawerItem(
                  Icons.map,
                  'Map View',
                  onTap: () {
                    Navigator.pushNamed(context, '/map');
                  },
                ),
                _buildDrawerItem(
                  Icons.settings,
                  'Settings',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                _buildDrawerItem(
                  Icons.info,
                  'About Us',
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                _buildDrawerItem(Icons.contact_page_outlined, 'Contact Us',
                    onTap: () {}),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome To",
                      style: GoogleFonts.lato(
                          fontSize: 24, color: MyColors.primaryColorBg)),
                  Text("SSGI Office Navigation",
                      style: GoogleFonts.lato(
                          fontSize: 24, color: MyColors.primaryColorBg)),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.tertiaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F0EF),
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
                              _searchDepartments();
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 52, 51, 51)),
                              border: InputBorder.none,
                            ),
                            style: textDisplaySmall,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: _searchDepartments,
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
                                  builder: (context) => const Info(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Rest Room",
                            style: GoogleFonts.josefinSans(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Rooms(
                            roomrsicon: '🥤',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Info()),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Lounge",
                            style: GoogleFonts.josefinSans(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          )
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
                                  builder: (context) => const Info(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Meeting",
                            style: GoogleFonts.josefinSans(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
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
                                  builder: (context) => const Info(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Library",
                            style: GoogleFonts.josefinSans(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          )
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
                    child: CategoryList(),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30.0)),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                    size: 32, // Increased size for better emphasis
                    color: _currentIndex == 0
                        ? MyColors.primaryColorBg
                        : Colors.grey,
                    shadows: [
                      if (_currentIndex == 0)
                        Shadow(
                            color: MyColors.primaryColorBg.withOpacity(0.4),
                            blurRadius: 6),
                    ],
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    size: 32,
                    color: _currentIndex == 1
                        ? MyColors.primaryColorBg
                        : Colors.grey,
                    shadows: [
                      if (_currentIndex == 1)
                        Shadow(
                            color: MyColors.primaryColorBg.withOpacity(0.4),
                            blurRadius: 6),
                    ],
                  ),
                  label: 'Camera',
                ),
              ],
              backgroundColor: const Color.fromARGB(255, 240, 239, 238),
              selectedItemColor: MyColors.primaryColorBg,
              unselectedItemColor: Colors.grey,
              elevation: 12, // Slightly higher elevation for depth
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });

                if (index == 0) {
                  // Additional action if needed
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraService()),
                  );
                }
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            height: 72,
            width: 72,
            child: FloatingActionButton(
              backgroundColor: MyColors.primaryColorBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
                side: const BorderSide(color: Colors.white, width: 3),
              ),
              elevation: 10,
              onPressed: () {},
              child: const Icon(Icons.my_location,
                  size: 32), // Slightly larger icon
            ),
          ),
        ));
  }

  Widget _buildDrawerItem(IconData icon, String title,
      {required Null Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, color: MyColors.primaryColor),
        title: Text(
          title,
          style: GoogleFonts.lato(fontSize: 16, color: MyColors.primaryColor),
        ),
        onTap: onTap,
      ),
    );
  }
}
