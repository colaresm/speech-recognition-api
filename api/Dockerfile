FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

COPY .env .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5001

CMD ["python", "main.py"]
