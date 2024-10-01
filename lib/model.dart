import 'dart:convert';

BookDetailModel bookDetailsModelFromJson(String str) => BookDetailModel.fromJson(json.decode(str));

String bookDetailsModelToJson(BookDetailModel data) => json.encode(data.toJson());

class BookDetailModel {
  final BookDetailData bookDetailData;

  BookDetailModel({
    required this.bookDetailData,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) =>
      BookDetailModel(
        bookDetailData: BookDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "data": bookDetailData.toJson(),
  };
}

class BookDetailData {
  final int bookId;
  final String bookName;
  final String? bookCoverImage;
  final String? bookDescription;
  final String? authorName;
  final String? authorImage;
  final int? publisherId;
  final int? categoryId;
  final int? courseId;
  final int? subCourseId;
  final int? authorId;
  final int? staffId;
  final int? totalChapters;
  final int? totalPages;
  final int? bookReadCount;
  final String? bookRating;
  final int? status;
  final int? newChapters;
  final String? fileurl;
  final int? firstPageNo;
  final String? categoryName;
  final String? courseName;
  final String? parentCategory;
  final String? staffName;
  final String? staffImage;
  final int? hasHardCopy;
  final int? hasSoftCopy;
  final double? hardCopyOldPrice;
  final double? hardCopyNewPrice;
  final double? softCopyOldPrice;
  final double? softCopyNewPrice;
  final String? publisherName;
  final String? publisherImage;
  final int? isSavedForLater;
  final int? weight;
  final int? length;
  final int? height;
  final int? breadth;
  final List<BookCategory> categories;
  final List<BookChapter> chapters;

  BookDetailData({
    required this.bookId,
    required this.bookName,
    this.bookCoverImage,
    this.bookDescription,
    this.authorName,
    this.authorImage,
    this.publisherId,
    this.categoryId,
    this.courseId,
    this.subCourseId,
    this.authorId,
    this.staffId,
    this.totalChapters,
    this.totalPages,
    this.bookReadCount,
    this.bookRating,
    this.status,
    this.newChapters,
    this.fileurl,
    this.firstPageNo,
    this.categoryName,
    this.courseName,
    this.parentCategory,
    this.staffName,
    this.staffImage,
    this.hasHardCopy,
    this.hasSoftCopy,
    this.hardCopyOldPrice,
    this.hardCopyNewPrice,
    this.softCopyOldPrice,
    this.softCopyNewPrice,
    this.publisherName,
    this.publisherImage,
    this.isSavedForLater,
    this.weight,
    this.length,
    this.height,
    this.breadth,
    required this.categories,
    required this.chapters,
  });

  factory BookDetailData.fromJson(Map<String, dynamic> json) => BookDetailData(
    bookId: json["id"] ?? 0,
    bookName: json["name"] ?? '',
    bookCoverImage: json["cover_image"] as String?,
    bookDescription: json["description"] as String?,
    authorName: json["author_name"] as String?,
    authorImage: json["author_image"] as String?,
    publisherId: json["publisher_id"] as int?,
    categoryId: json["category_id"] as int?,
    courseId: json["course_id"] as int?,
    subCourseId: json["sub_course_id"] as int?,
    authorId: json["author_id"] as int?,
    staffId: json["staff_id"] as int?,
    totalChapters: json["chapters"] as int?,
    totalPages: json["pages"] as int?,
    bookReadCount: json["reads"] as int?,
    bookRating: json["rating"] as String?,
    status: json["stage"] as int?,
    newChapters: json["new_chapters"] as int?,
    fileurl: json["file_url"] as String?,
    firstPageNo: json["first_page_no"] as int?,
    categoryName: json["category_name"] as String?,
    courseName: json["course_name"] as String?,
    parentCategory: json["parent_category"] as String?,
    staffName: json["staff_name"] as String?,
    staffImage: json["staff_image"] as String?,
    hasHardCopy: json["has_hard_copy"] as int?,
    hasSoftCopy: json["has_soft_copy"] as int?,
    hardCopyOldPrice: (json["hard_copy_old_price"] != null)
        ? json["hard_copy_old_price"].toDouble()
        : null,
    hardCopyNewPrice: (json["hard_copy_new_price"] != null)
        ? json["hard_copy_new_price"].toDouble()
        : null,
    softCopyOldPrice: (json["soft_copy_old_price"] != null)
        ? json["soft_copy_old_price"].toDouble()
        : null,
    softCopyNewPrice: (json["soft_copy_new_price"] != null)
        ? json["soft_copy_new_price"].toDouble()
        : null,
    publisherName: json["publisher_name"] as String?,
    publisherImage: json["publisher_image"] as String?,
    isSavedForLater: json["is_saved_for_later"] as int?,
    weight: json["weight"] as int?,
    length: json["length"] as int?,
    height: json["height"] as int?,
    breadth: json["breadth"] as int?,
    categories: json["category"] != null
        ? List<BookCategory>.from(
        json["category"].map((x) => BookCategory.fromJson(x)))
        : [],
    chapters: json["chapter"] != null
        ? List<BookChapter>.from(
        json["chapter"].map((x) => BookChapter.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": bookId,
    "name": bookName,
    "cover_image": bookCoverImage,
    "description": bookDescription,
    "author_name": authorName,
    "author_image": authorImage,
    "publisher_id": publisherId,
    "category_id": categoryId,
    "course_id": courseId,
    "sub_course_id": subCourseId,
    "author_id": authorId,
    "staff_id": staffId,
    "chapters": totalChapters,
    "pages": totalPages,
    "reads": bookReadCount,
    "rating": bookRating,
    "stage": status,
    "new_chapters": newChapters,
    "file_url": fileurl,
    "first_page_no": firstPageNo,
    "category_name": categoryName,
    "course_name": courseName,
    "parent_category": parentCategory,
    "staff_name": staffName,
    "staff_image": staffImage,
    "has_hard_copy": hasHardCopy,
    "has_soft_copy": hasSoftCopy,
    "hard_copy_old_price": hardCopyOldPrice,
    "hard_copy_new_price": hardCopyNewPrice,
    "soft_copy_old_price": softCopyOldPrice,
    "soft_copy_new_price": softCopyNewPrice,
    "publisher_name": publisherName,
    "publisher_image": publisherImage,
    "is_saved_for_later": isSavedForLater,
    "weight": weight,
    "length": length,
    "height": height,
    "breadth": breadth,
    "category": List<dynamic>.from(categories.map((x) => x.toJson())),
    "chapter": List<dynamic>.from(chapters.map((x) => x.toJson())),
  };
}

class BookCategory {
  final int id;
  final int bookId;
  final int categoryId;
  final String categoryName;
  final String categoryIcon;

  BookCategory({
    required this.id,
    required this.bookId,
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) => BookCategory(
    id: json["id"] ?? 0,
    bookId: json["book_id"] ?? 0,
    categoryId: json["category_id"] ?? 0,
    categoryName: json["category_name"] ?? '',
    categoryIcon: json["category_icon"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_id": bookId,
    "category_id": categoryId,
    "category_name": categoryName,
    "category_icon": categoryIcon,
  };
}

class BookChapter {
  final int id;
  final int bookId;
  final int chapterIndex;
  final String chapterName;
  final int pages;
  final int startPageNumber;
  final int endPageNumber;
  final String chapterUrl;

  BookChapter({
    required this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.chapterName,
    required this.pages,
    required this.startPageNumber,
    required this.endPageNumber,
    required this.chapterUrl,
  });

  factory BookChapter.fromJson(Map<String, dynamic> json) => BookChapter(
    id: json["id"] ?? 0,
    bookId: json["book_id"] ?? 0,
    chapterIndex: json["chapter_index"] ?? 0,
    chapterName: json["chapter_name"] ?? '',
    pages: json["pages"] ?? 0,
    startPageNumber: json["start_page_number"] ?? 0,
    endPageNumber: json["end_page_number"] ?? 0,
    chapterUrl: json["chapter_url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_id": bookId,
    "chapter_index": chapterIndex,
    "chapter_name": chapterName,
    "pages": pages,
    "start_page_number": startPageNumber,
    "end_page_number": endPageNumber,
    "chapter_url": chapterUrl,
  };
}