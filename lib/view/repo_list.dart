import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/repo_provider.dart';

class RepoListScreen extends StatelessWidget {
  const RepoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RepoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("GitHub Starred Repos")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: provider.repos.length,
        itemBuilder: (context, index) {
          final repo = provider.repos[index];
          return ListTile(
            leading: const Icon(Icons.star, color: Colors.amber),
            title: Text(repo.name),
            subtitle: Text(repo.url),
            trailing: Text(
              repo.stars.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}