class TodoList {
  List<Post> post;

  TodoList({this.post});

  TodoList.fromJson(Map<String, dynamic> json) {
    if (json['post'] != null) {
      post = <Post>[];
      json['post'].forEach((v) {
        post.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

///model de dados para listar posts
class Post {
  String sId;
  String title;
  String content;
  String createdAt;
  int iV;

  // construtor base
  Post({this.sId, this.title, this.content, this.createdAt, this.iV});

  //decode de json
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        sId: json['_id'],
        title: json['title'],
        content: json['content'],
        createdAt: json['createdAt'],
        iV: json['__v']);
  }

  // converte json list para lista de objetos
  static List<Post> fromJsonList(dynamic json) {
    List<Post> posts;
    if (json != null) {
      posts = json.map<Post>((pst) {
        return Post.fromJson(pst);
      }).toList();
    }
    return posts;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
