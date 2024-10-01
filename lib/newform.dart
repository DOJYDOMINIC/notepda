import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({Key? key}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late BookDetailModel jsonData; // Define the variable to hold the book details
  bool isLoading = true; // State to manage loading status

  @override
  void initState() {
    super.initState();
    fetchBookDetails();
  }

  String getStageDescription(int? stage) {
    switch (stage) {
      case 1:
        return "Ongoing";
      case 2:
        return "Complete";
      case 3:
        return "New Update";
      default:
        return "Unknown Stage";
    }
  }

  // status color update
  Color getStageColor(int? stage) {
    switch (stage) {
      case 1:
        return Color.fromRGBO(255, 190, 5, 1); // Ongoing
      case 2:
        return Color.fromRGBO(141, 255, 159, 1); // Complete
      case 3:
        return Color.fromRGBO(236, 81, 81, 1); // New Update
      default:
        return Colors.red; // Unknown Stage
    }
  }

  Future<void> fetchBookDetails() async {
    try {
      final url =
          Uri.parse("https://app.notespaediaapp.com/api/books/books/167");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          jsonData = bookDetailsModelFromJson(response.body);
          isLoading = false;
        });

        print(jsonData.bookDetailData.bookName);
      } else {
        print('Failed to fetch book details: ${response.statusCode}');
      }
    } catch (error) {
      // Handle the exception
      print("Exception: $error");
    }
  }

  int? selectedIndex = 0;

  double _getTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.size.width;
  }

  final List<String> items = [
    'Chapters',
    'Reviews',
    'Read more',
    'Related books',
    'Courses',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${jsonData.bookDetailData.bookName}",
                    style: TextStyle(
                      fontSize: 14,
                      // Font size in pixels
                      fontWeight: FontWeight.w300,
                      // Font weight (300 = Light)
                      height: 16.8 / 14,
                      // Line height as a ratio (line-height / font-size)
                      color: Colors.black, // Default color, change as needed
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${jsonData.bookDetailData.hardCopyOldPrice?.toInt()}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                          // Set the strikethrough color to grey
                          decorationThickness:
                              2.0, // Optional: Set the thickness of the line
                        ),
                      ),
                      Text(
                        "₹${jsonData.bookDetailData.hardCopyNewPrice?.toInt()}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 44,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(141, 255, 159, 1),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: const Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.grey.shade50,
                    actions: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.save_alt)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_border_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_outlined)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildBookImage(jsonData.bookDetailData),
                        //cover image
                        const SizedBox(height: 34),
                        _buildStatsRow(jsonData.bookDetailData),
                        //row reads,rating,chaptres,pages
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: _buildDividerRow(jsonData.bookDetailData.categories)),
                        const SizedBox(height: 16),
                        _buildDescription(
                            "With Chrome profiles you can separate all of your Chrome stuff. Create profiles for friends and family, or split between work and fun.With Chrome profiles you can separate all of your Chrome stuff. Create profiles for friends and family, or split between work and fun.With Chrome profiles you can separate all of your Chrome stuff. Create profiles for friends and family, or split between work and fun."),
                        const SizedBox(height: 24),
                        _buildHorizontalMenu(jsonData.bookDetailData.chapters),
                        const SizedBox(height: 16),
                        _buildDownloadSection(),
                        ChapterListView(data: jsonData.bookDetailData)
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildBookImage(BookDetailData data) {
    return Center(
      child: Stack(
        children: [
          // Book image container
          Container(
            height: 395,
            width: 328,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              // Apply borderRadius to the image
              child: Image.network(
                data.bookCoverImage.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            height: 395,
            width: 328,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.grey.shade50.withOpacity(0.5),
                  // Adjust opacity for better visual effect
                  Colors.grey.shade50,
                ],
              ),
            ),
          ),
          // Positioned book info at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBookInfo(data.bookName, data.parentCategory.toString(),
                getStageDescription(data.status)),
          ),
        ],
      ),
    );
  }

  Widget _buildBookInfo(String name, String description, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          _buildStatusBadge(status),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildReadButton(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      width: 79,
      height: 23,
      decoration: BoxDecoration(
        color: getStageColor(jsonData.bookDetailData.status),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildReadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 44,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(36),
          ),
          child: const Center(
            child: Text(
              "Read",
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(BookDetailData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatCard(data.bookReadCount.toString(), 'Reads'),
        _buildStatCard(data.bookRating.toString(), 'Rating'),
        _buildStatCard(data.totalChapters.toString(), 'Chapters'),
        _buildStatCard(data.totalPages.toString(), 'Pages'),
      ],
    );
  }

  Widget _buildStatCard(String numberText, String descriptionText) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white, // Set your container color
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(68, 68, 68, 0.04),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            numberText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            descriptionText,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerRow(List<dynamic> categories) {
    List<Widget> categoryWidgets = [];

    for (int i = 0; i < categories.length; i++) {
      // Wrap the category widget in a SizedBox to set fixed dimensions
      categoryWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 24),
          child: SizedBox(
            width: 88, // Set the width to 88 pixels
            height: 48, // Set the height to 44 pixels
            child: _buildDividerData(
              categories[i].categoryIcon,
              categories[i].categoryName,
            ),
          ),
        ),
      );

      // Add a vertical divider after each category, except the last one
      if (i < categories.length - 1) {
        categoryWidgets.add(
          Container(
            color: Colors.black.withOpacity(.5),
            width: .5,
            height: 29,
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categoryWidgets,
    );
  }


// Category item widget
  Widget _buildDividerData(String iconUrl, String categoryName) {
    return Column(
      children: [
        Image.network(
          iconUrl,
          width: 24, // Adjust as per your requirement
          height: 24,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 5),
        Text(
          categoryName,
          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildDescription(String description) {
    return ReadMoreText(
      description,
      trimMode: TrimMode.Line,
      trimLines: 5,
      colorClickableText: Colors.pink,
      trimCollapsedText: ' Read more',
      trimExpandedText: ' Show Less',
      moreStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(141, 255, 159, 1)),
      // Style for 'Read more'
      lessStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(141, 255, 159, 1)), // Style for 'Show less'
    );
  }

  Widget _buildHorizontalMenu(List<BookChapter> chapters) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(items.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 16,
                    right: 16,
                  ),
                  child: Text(
                    items[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:
                          selectedIndex == index ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                if (selectedIndex == index)
                  Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : 16,
                      right: 16,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 2,
                      width: _getTextWidth(
                        items[index],
                        const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDownloadSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Chapters",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        _buildDownloadButton(),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: const [
            Text(
              "Download",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.save_alt,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterListView extends StatelessWidget {
  final BookDetailData data;

  const ChapterListView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.chapters.length,
            itemBuilder: (context, index) {
              // Access the chapters in reverse order
              var chapters = data.chapters[data.chapters.length - 1 - index];

              return Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Container(
                        width: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            10,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Container(
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                                radius: 14,
                                child: Text("${index + 1}"),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(68, 68, 68, 0.04),
                                    blurRadius: 12,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(chapters.chapterName),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow.shade700,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  data.bookRating.toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Container(
                                                height: 10,
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                            ),
                                            Text(
                                              "${chapters.pages} pgs",
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.save_alt,
                                      color: Colors.grey.shade400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
