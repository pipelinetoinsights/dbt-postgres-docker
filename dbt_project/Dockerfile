FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /dbt

# Install dbt-postgres
RUN pip install dbt-postgres

# Copy project files
COPY . .

# Create profiles directory
RUN mkdir -p /dbt/profiles

# Set environment variables
ENV DBT_PROFILES_DIR=/dbt/profiles
ENV DBT_PROJECT_DIR=/dbt

# Default command
CMD ["tail", "-f", "/dev/null"] 