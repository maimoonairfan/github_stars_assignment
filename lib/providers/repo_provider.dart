import 'package:flutter/material.dart';
import '../models/repo_model.dart';
import '../services/db_services.dart';

class RepoProvider extends ChangeNotifier {
  List<GithubRepo> _repos = [];
  bool _isLoading = false;

  List<GithubRepo> get repos => _repos;
  bool get isLoading => _isLoading;

  final DBService _dbService = DBService();

  Future<void> loadRepos() async {
    _isLoading = true;
    notifyListeners(); 

    _repos = await _dbService.fetchReposFromDB();

    _isLoading = false;
    notifyListeners();
  }
}
