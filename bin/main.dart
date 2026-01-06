import 'package:graphql/client.dart';
import 'package:postgres/postgres.dart';

// 1. GitHub Token
const String GITHUB_TOKEN = "";

void main() async {

  final conn = await Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'github_crawler',
      username: 'postgres',
      password: 'bosch123+',
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );

  print("Database connected!");

  // 3. GitHub GraphQL Setup
  final _httpLink = HttpLink('https://api.github.com/graphql');
  final _authLink = AuthLink(getToken: () async => 'Bearer $GITHUB_TOKEN');
  final link = _authLink.concat(_httpLink);
  final client = GraphQLClient(link: link, cache: GraphQLCache());

  // 4. Query (100 Repositories mangne ke liye)
  const String query = r'''
    query {
      search(query: "stars:>1000", type: REPOSITORY, first: 100) {
        nodes {
          ... on Repository {
            id
            nameWithOwner
            url
            stargazerCount
          }
        }
      }
    }
  ''';

  final result = await client.query(QueryOptions(document: gql(query)));

  if (result.hasException) {
    print(result.exception.toString());
    return;
  }

  final repos = result.data?['search']['nodes'];

  // 5. Data ko Postgres mein insert karein
  for (var repo in repos) {
    await conn.execute(
      r'INSERT INTO repositories (id, name_with_owner, url, stargazer_count) '
      r'VALUES ($1, $2, $3, $4) ON CONFLICT (id) DO UPDATE SET stargazer_count = $4',
      parameters: [
        repo['id'],
        repo['nameWithOwner'],
        repo['url'],
        repo['stargazerCount'],
      ],
    );
  }

  print("100 Repositories successfully saved to Database!");
  await conn.close();
}