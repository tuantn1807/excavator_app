import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostService postService;
  List<PostModel> _posts = [];
  bool _isLoading = false;

  PostProvider(this.postService);

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts({bool refresh = false}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await postService.getPosts();
      _posts = response.data;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
