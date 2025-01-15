
# Demo Application with InfluxDB, Grafana, and Docker Compose

This project is a Spring Boot application configured with Actuator and Micrometer to export metrics to InfluxDB. It is containerized using Docker and orchestrated with Docker Compose, including services for InfluxDB v1, InfluxDB v2, and Grafana. Grafana is provisioned to use InfluxDB as a datasource and display dashboards from the provided configuration.

## Project Structure

```
├── Dockerfile
├── HELP.md
├── build.gradle
├── docker-compose.yml
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
├── grafana
│   ├── dashboard_provisioning.yaml
│   ├── dashboards
│   │   └── micrometer.json
│   └── grafana-datasource-config.yaml
├── settings.gradle
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── example
    │   │           └── demo
    │   │               ├── DemoApplication.java
    │   │               └── HelloController.java
    │   └── resources
    │       └── application.properties
    └── test
        └── java
            └── com
                └── example
                    └── demo
                        └── DemoApplicationTests.java
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your machine.
- [Docker Compose](https://docs.docker.com/compose/install/) installed.
- Git (optional, for cloning the repository).

## Installation

### Install Docker Compose

Follow the official instructions for installing Docker Compose on your OS:
- **Linux**:
  ```bash
  sudo curl -L "https://github.com/docker/compose/releases/download/<version>/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  ```
  Replace `<version>` with the desired version number (e.g., `1.29.2`).

- **Windows & macOS**:  
  Docker Desktop includes Docker Compose by default. Install Docker Desktop from [here](https://www.docker.com/products/docker-desktop) if you haven't already.

### Clone the Repository (if applicable)

```bash
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```
*(Replace the URL with your repository URL.)*

## Running the Application with Docker Compose

1. **Build and start the containers**:  
   In the root directory where `docker-compose.yml` is located, run:

   ```bash
   docker-compose build --no-cache
   docker-compose up -d
   ```

    - `docker-compose build --no-cache` builds the Docker images without using the cache.
    - `docker-compose up -d` starts all services in detached mode.

2. **Verify containers are running**:  
   Run `docker-compose ps` to list running containers. You should see containers for `demo_app`, `influxdb_v1`, `influxdb_v2`, and `grafana`.

## Accessing the Application and Services

- **Spring Boot Application**:  
  Open your browser and go to [http://localhost:9090/hello](http://localhost:9090/hello). You should see a response: `Hello, world!`.

- **Grafana Dashboard**:
    1. Open your browser and go to [http://localhost:3000](http://localhost:3000).
    2. Log in with the default credentials:
        - **Username**: `admin`
        - **Password**: `admin`
    3. Grafana will load the provisioned dashboards and datasources automatically.
    4. Navigate to the dashboards section to view the Micrometer dashboard displaying metrics from your Spring Boot application.

## Configuration Details

- **application.properties**:  
  Located in `src/main/resources/application.properties`, it configures the Spring Boot app with Actuator endpoints and Micrometer settings for InfluxDB export.

- **Dockerfile**:  
  Defines how to build and run the Spring Boot application using Java 17, Gradle, and OpenJDK 17.

- **docker-compose.yml**:  
  Orchestrates multiple services:
    - `demo_app`: Your Spring Boot application.
    - `influxdb_v1` & `influxdb_v2`: InfluxDB databases.
    - `grafana`: Grafana service, configured via provisioned datasource and dashboards in the `grafana/` directory.

- **Grafana Provisioning**:
    - `grafana/grafana-datasource-config.yaml`: Defines the InfluxDB datasource.
    - `grafana/dashboard_provisioning.yaml`: Configures Grafana to load dashboards from `grafana/dashboards/`.
    - `grafana/dashboards/micrometer.json`: Contains the dashboard JSON for Micrometer metrics.

## Stopping and Removing Containers

To stop the containers without removing them:

```bash
docker-compose stop
```

To stop and remove all containers, networks, and volumes defined in `docker-compose.yml`:

```bash
docker-compose down -v
```

## Troubleshooting

- Ensure Docker and Docker Compose are installed correctly.
- If a container fails to start, use `docker-compose logs <service_name>` to view logs for debugging.

---

This README provides an overview of how to set up and run the Spring Boot application along with InfluxDB and Grafana using Docker Compose. Adjust configurations as needed for your environment.
