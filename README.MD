# Speech Recognition Based Login System

This repository stores a Python-based API, containerized with Docker and integrated with MongoDB, focused on speaker recognition. The system extracts voice features using MFCC coefficients and performs identification through the Mahalanobis distance, comparing input audio samples with previously registered speaker profiles.

# Technologies


#  Overview
This project uses a **Python-based API** containerized with **Docker**. When the application is started, the **MongoDB** and **mongo-express** containers are automatically created, providing an isolated and reproducible environment.

## Application Startup

To start the API, navigate to the `api` directory and run the following command:

```bash
docker compose up -d
```

After a successful startup, the services will be available as described below.

## API Access

The API will be available at the following address:

- **API / Documentation (Swagger):**  
  http://localhost:5001/apidocs/#/

The interactive documentation allows you to explore the available endpoints and make requests directly through the interface.

## Mongo Express Access

The **mongo-express** web interface can be accessed at:

- **Mongo Express:**  
  http://localhost:8081/

Use the following credentials to log in:

- **Username:** `admin`  
- **Password:** `password`



#  Graphical interface
<p align = "center">
  <img src="docs/home.png" width="200" />
  <img src="docs/register.png" width="200" />
  <img src="docs/login.png" width="200" />
  <img src="docs/profile.png" width="200" />
</p>


