class UserPosts {
  List<Data> data;

  UserPosts({this.data});

  UserPosts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int postId;
  String title;
  String slug;
  String description;
  int status;
  String statusText;
  int commentAble;
  String createDate;
  Category category;
  List<Tags> tags;
  List<Media> media;
  int commentsCount;
  List<Comments> comments;

  Data(
      {this.postId,
      this.title,
      this.slug,
      this.description,
      this.status,
      this.statusText,
      this.commentAble,
      this.createDate,
      this.category,
      this.tags,
      this.media,
      this.commentsCount,
      this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    status = json['status'];
    statusText = json['status_text'];
    commentAble = json['comment_able'];
    createDate = json['create_date'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
    commentsCount = json['comments_count'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['status'] = this.status;
    data['status_text'] = this.statusText;
    data['comment_able'] = this.commentAble;
    data['create_date'] = this.createDate;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    data['comments_count'] = this.commentsCount;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int categoryId;
  String name;

  Category({this.categoryId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    return data;
  }
}

class Tags {
  int tagId;
  String name;

  Tags({this.tagId, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['name'] = this.name;
    return data;
  }
}

class Media {
  String fileName;
  String fileType;
  String fileSize;
  String url;

  Media({this.fileName, this.fileType, this.fileSize, this.url});

  Media.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileSize = json['file_size'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = this.fileName;
    data['file_type'] = this.fileType;
    data['file_size'] = this.fileSize;
    data['url'] = this.url;
    return data;
  }
}

class Comments {
  int commentId;
  String name;
  String email;
  String website;
  String comment;
  int status;
  String statusText;
  String auther;
  String createDate;

  Comments(
      {this.commentId,
      this.name,
      this.email,
      this.website,
      this.comment,
      this.status,
      this.statusText,
      this.auther,
      this.createDate});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    name = json['name'];
    email = json['email'];
    website = json['website'];
    comment = json['comment'];
    status = json['status'];
    statusText = json['status_text'];
    auther = json['auther'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['website'] = this.website;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['status_text'] = this.statusText;
    data['auther'] = this.auther;
    data['create_date'] = this.createDate;
    return data;
  }
}
