FROM python:3.11-slim

# Install system dependencies required for mysqlclient
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app
COPY . /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project
COPY . .

# Expose port
EXPOSE 8000

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Run server
CMD ["/wait-for-it.sh", "mysql-db:3306", "--", "python", "manage.py", "runserver", "0.0.0.0:8000"]

# Give execution permission to the script
RUN chmod +x /app/wait-for-it.sh