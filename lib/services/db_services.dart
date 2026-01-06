import 'package:postgres/postgres.dart';
import '../models/repo_model.dart';

class DBService {
  Future<List<GithubRepo>> fetchReposFromDB() async {
    final conn = await Connection.open(
      Endpoint(
        host: '172.16.24.22',
        port: 5432,
        database: 'github_crawler',
        username: 'postgres',
        password: 'bosch123+',
      ),
      settings: const ConnectionSettings(
        sslMode: SslMode.disable,
        connectTimeout: Duration(seconds: 10), // Timeout thoda barha den
      ),
    );
    final results = await conn.execute('SELECT * FROM repositories ORDER BY stargazer_count DESC');

    await conn.close();

    return results.map((row) => GithubRepo.fromMap(row.toColumnMap())).toList();
  }
}