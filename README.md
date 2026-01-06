# GitHub Stars Crawler & Viewer

### 1. Scaling to 500 Million Repositories
- **Distributed Crawling:** Use multiple worker containers to fetch data in parallel.
- **Database Sharding:** Partition the PostgreSQL database to handle millions of rows efficiently.
- **Rate Limit Management:** Use a pool of GitHub tokens and rotate them to avoid API limits.
- **Queuing:** Implement RabbitMQ or Kafka for task management and retries.

### 2. Schema Evolution (Metadata: PRs, Issues, Comments)
- **Normalisation:** Create separate tables for `pull_requests` and `comments`, linked by `repo_id`.
- **Efficient Updates:** Use `UPSERT` logic to update only changed rows (minimal row impact).
- **Indexing:** Use proper indexing on `repo_id` and `updated_at` for fast querying.
