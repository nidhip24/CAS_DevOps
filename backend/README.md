
# **CAS Application**

A containerized application that uses Docker and Docker Compose for easy deployment and management. The project includes database migrations using Alembic to manage schema changes effectively.

---

## Features

- **FastAPI Framework**: High performance, asynchronous API.
- **Authentication**: JWT-based user authentication and token management.
- **Database Integration**: SQLAlchemy ORM with support for PostgreSQL/MySQL.
- **Modular Architecture**: Scalable and maintainable structure.
- **API Documentation**: Auto-generated Swagger UI and ReDoc.
- **Error Handling**: Custom exception handling for validation and business logic errors.

---

## **Prerequisites**

Ensure the following tools are installed on your system before proceeding:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- A terminal or command-line tool
- [Postman](https://www.postman.com/) for API testing

---

## **Getting Started**

Follow these steps to set up and run the application on your local machine.

### **1. Clone the Repository**

```bash
git clone https://github.com/nidhip24/cas.git
cd cas
```

---

### **2. Build the Docker Image (Optional)**

Use `docker buildx` to create a cross-platform Docker image:

```bash
docker buildx build --platform linux/amd64 -t nidhip24/cas:latest .
```

**Explanation**:
- `--platform linux/amd64`: Ensures compatibility with AMD64 architecture.
- `-t nidhip24/cas:latest`: Tags the image for easier reference.

---

### **3. Run the Application**

Start the application and its dependencies (like the database) using Docker Compose:

```bash
docker compose up -d
```

**Explanation**:
- `up`: Starts the services defined in `docker-compose.yaml`.
- `-d`: Runs the services in detached mode (in the background).

---

### **4. Apply Database Migrations**

Run Alembic migrations to set up the database schema:

```bash
docker exec -it cas_app alembic upgrade head
```

**Explanation**:
- `exec`: Executes a command inside the running container.
- `-it`: Allows interaction with the container’s terminal.
- `app`: Refers to the application container defined in `docker-compose.yaml`.
- `alembic upgrade head`: Applies all database migrations to bring the schema up to date.

---

### **5. Access the Application**

The application runs on port `8000` by default. Access it in your browser at:

```
http://localhost:8000
```

Refer to the project documentation for API endpoints and further details.

---


### **6. Run Tests and Generate Coverage Report**

#### **Option 1: Simple Test Execution**
Run tests with detailed output:

```bash
docker exec cas_app pytest tests/ -s -vv --tb=line
```

**Explanation**:
- `pytest tests/`: Runs all test cases located in the `tests/` directory.
- `-s`: Prevents output capturing, allowing logs to be displayed in real time.
- `-vv`: Provides verbose test output.
- `--tb=line`: Displays test tracebacks in a single line for clarity.

#### **Option 2: Tests with Coverage**
To execute tests and generate a coverage report, run the following command:

```bash
docker exec -it cas_app pytest tests/ --cov=src --cov-report=term-missing
```

**Explanation**:
- `pytest tests/`: Runs all test cases located in the `tests/` directory.
- `--cov=src`: Measures code coverage for the `src/` directory.
- `--cov-report=term-missing`: Displays uncovered lines in the terminal.

View the test results and ensure all tests pass.


---

### **7. Tear Down the Application**

To stop the application and clean up resources, use:

```bash
docker-compose down --volumes
```

**Explanation**:
- `down`: Stops and removes all containers, networks, and services created by `docker-compose up`.
- `--volumes`: Removes associated Docker volumes to ensure a clean environment.

---

## Usage

### Access the API
- **Swagger UI**: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
- **ReDoc**: [http://127.0.0.1:8000/redoc](http://127.0.0.1:8000/redoc)

---

## **API Testing**

### **Postman Collection**
For testing the APIs, you can use the provided Postman collection. Import the `CASV1.postman_collection.json` file into Postman.

#### **Steps to Use Postman Collection**
1. Open Postman.
2. Click on **Import**.
3. Select the `CASV1.postman_collection.json` file.
4. Set the `{{server}}` variable to `http://localhost:8000`.
5. Execute the predefined requests for operations like:
   - User Registration
   - Login
   - App Creation
   - Listing Apps
   - App User Registration
   - App User Login

**Collection File**: [CASV1.postman_collection.json](CASV1.postman_collection.json)


## **Workflow Summary**

| **Command**                                | **Description**                           |
|--------------------------------------------|-------------------------------------------|
| `git clone https://github.com/nidhip24/cas.git` | Clone the repository.                     |
| `cd cas`                                   | Navigate into the project directory.       |
| `docker buildx build --platform linux/amd64 -t nidhip24/cas:latest .` | Build the Docker image(optional).                   |
| `docker compose up -d`                     | Start the application and services.        |
| `docker exec -it cas_app alembic upgrade head` | Apply database migrations.                |
| `http://localhost:8000`                    | Access the application in the browser.     |
| `docker-compose down --volumes`            | Tear down the application and services.    |

---

## **Troubleshooting**

### **1. Check Running Containers**
Use the following command to ensure all containers are running:
```bash
docker ps
```

### **2. Inspect Logs**
If a service fails to start, view the logs for detailed error information:
```bash
docker logs <container_name>
```

### **3. Verify Database Readiness**
Ensure the database is ready before applying migrations. Use this command to wait for the database:
```bash
docker exec -it cas_app sh -c "while ! nc -z db 3306; do echo 'Waiting for database...'; sleep 2; done; echo 'Database is ready!'"
```

---

## **License**

This project is licensed under the [MIT License](LICENSE).

---

## **Contact**

For questions or feedback, feel free to reach out:

- **Name**: Nidhip Kathiriya
- **Email**: nidhipkathiriya@gmail.com
- **GitHub**: [nidhip24](https://github.com/nidhip24)
