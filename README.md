# dbt-Postgres Data Engineering Project with Docker

This project demonstrates a data engineering pipeline using [dbt](https://www.getdbt.com/) and [Postgres](https://www.postgresql.org/) with Docker. It includes:
- A Postgres database preloaded with seed data.
- A dbt project with staging and mart models.
- All infrastructure managed via Docker Compose

## Project Structure
```
.
├── docker-compose.yml
├── profiles.yml
├── dbt_project/
│   ├── Dockerfile
│   ├── dbt_project.yml
│   ├── models/
│   │   ├── marts/
│   │   │   └── dim_customers.sql
│   │   └── staging/
│   │       ├── stg_customers.sql
│   │       └── stg_orders.sql
│   └── seeds/
│       ├── customers.csv
│       └── orders.csv
```

## Getting Started

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed

### 1. Build and Start the Services
```sh
docker-compose up --build
```
This will start both Postgres and the dbt container.

### 2. Load Seed Data and Run dbt Models
Open a new terminal and run:
```sh
docker exec -it dbt_container bash
```
Inside the container, run:
```sh
dbt seed      # Loads seed data into Postgres

# Build models

dbt run       # Builds staging and mart models

dbt test      # Runs tests on your models
```

### 3. Inspect the Database
You can connect to the Postgres container:
```sh
docker exec -it dbt_postgres psql -U dbt_user -d dbt_demo
```

List tables:
```
\dt
```

Query data:
```
SELECT * FROM customers LIMIT 5;
SELECT * FROM stg_customers LIMIT 5;
SELECT * FROM dim_customers LIMIT 5;
```

## Troubleshooting
- **Container name conflict:** Remove old containers with `docker rm <container_name>`
- **Seeds not loading:** Ensure seed CSVs are in `dbt_project/seeds/`
- **Schema issues:** By default, seeds are loaded into the `public` schema. Check your `sources.yml` for correct schema.
- **psql not found:** Use the Postgres container, not the dbt container, to access the database directly.

## Customization
- Add more seed files to `dbt_project/seeds/`
- Add new models to `dbt_project/models/`
- Update `dbt_project.yml` and `profiles.yml` as needed

## References
- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [Postgres Documentation](https://www.postgresql.org/docs/)
- [Docker Compose Docs](https://docs.docker.com/compose/) 