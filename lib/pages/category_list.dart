import 'package:ar_navigation/pages/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class CategoryList extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 4.0),
      child: SizedBox(
        height: 300,
        child: ListView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          children: [
            buildCategoryCard(
              context,
              "assets/images/rocket.jpg",
              "Rocket Launch Animation",
              "Aeronautics and Astronautics",
              "Focuses on advanced aeronautics and space applications, preparing students for careers in designing aircraft, UAVs, and rockets.",
              false,
            ),
            buildCategoryCard(
              context,
              "assets/images/starry.jpg",
              "Starry Night Animation",
              "Entoto Observatory and Space Science Research Center",
              "Dedicated to astronomical research and remote sensing, providing insights into space science and application development.",
              false,
            ),
            buildCategoryCard(
              context,
              "assets/images/globe.mp4",
              "Globe Animation",
              "Geodesy and Geo-dynamic Research",
              "Focuses on Earth measurement techniques, understanding geodynamics, and monitoring changes in the Earth's surface.",
              true,
            ),
            buildCategoryCard(
              context,
              "assets/images/library.jpg",
              "Digital Library Animation",
              "Academic Center",
              "Offers postgraduate education and resources, supporting research and collaboration in space sciences.",
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCard(BuildContext context, String mediaPath,
      String animationText, String title, String description, bool isVideo) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Info()),
          );
        },
        child: Container(
          height: 200,
          width: 250,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F0EF),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: GoogleFonts.josefinSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: isVideo
                        ? VideoPlayerWidget(mediaPath)
                        : Image.asset(
                            mediaPath,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Text(
                  description,
                  style: GoogleFonts.josefinSans(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget(this.videoPath, {super.key});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); // Update the UI after the video is initialized
        _controller.setLooping(true); // Set video to loop
        _controller.play(); // Start playing the video
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container(
            height: 100,
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator()),
          );
  }
}
