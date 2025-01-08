cd /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/immutable/_vmctl/_script/database
docker build -t ecommere-sqlserver:latest .
docker compose -f 'docker_compose_sql_server' up -d