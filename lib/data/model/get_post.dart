class GetPosts {
  List<Data> data;
  Meta meta;

  GetPosts({this.data, this.meta});

  GetPosts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Data {
  String title;
  String slug;
  String description;
  String status;
  int commentAble;
  String createDate;
  Author author;
  Category category;
  List<Tags> tags;
  List<Media> media;
  int comments;
  int activeComments;

  Data(
      {this.title,
      this.slug,
      this.description,
      this.status,
      this.commentAble,
      this.createDate,
      this.author,
      this.category,
      this.tags,
      this.media,
      this.comments,
      this.activeComments});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    status = json['status'];
    commentAble = json['comment_able'];
    createDate = json['create_date'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
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
    comments = json['comments'];
    activeComments = json['active_comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['status'] = this.status;
    data['comment_able'] = this.commentAble;
    data['create_date'] = this.createDate;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['active_comments'] = this.activeComments;
    return data;
  }
}

class Author {
  String name;
  String username;
  String status;
  String bio;
  String userImage;

  Author({this.name, this.username, this.status, this.bio, this.userImage});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    status = json['status'];
    bio = json['bio'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['status'] = this.status;
    data['bio'] = this.bio;
    data['user_image'] = this.userImage;
    return data;
  }
}

class Category {
  String name;
  String slug;
  int postCount;

  Category({this.name, this.slug, this.postCount});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    postCount = json['post_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['post_count'] = this.postCount;
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

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Links> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Links {
  String url;
  var label;
  bool active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class Tags {
  String name;
  String slug;
  int postCount;

  Tags({this.name, this.slug, this.postCount});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    postCount = json['post_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['post_count'] = this.postCount;
    return data;
  }
}
