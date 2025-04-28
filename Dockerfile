FROM python:3.11.3-slim-buster 

WORKDIR /app

# Set env variables
ENV PYTHONDONTWRITEBYTECODE=1 
ENV PYTHONUNBUFFERED=1 
ENV PYTHONPATH="/code" 
ENV DEBUG=True 

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*
# Copy & install dependencies

COPY app/ /app

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

EXPOSE 80/tcp

ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=80", "--server.address=0.0.0.0"]

