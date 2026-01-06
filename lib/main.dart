import 'package:flutter/material.dart';
import 'package:github_stars_assignment/providers/repo_provider.dart';
import 'package:github_stars_assignment/view/repo_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RepoProvider()..loadRepos(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RepoListScreen(),
    );
  }
}
