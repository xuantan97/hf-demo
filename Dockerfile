FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Create group and user correctly for Debian
RUN groupadd -g 10014 choreo && \
    useradd -u 10014 -g choreo -M -s /usr/sbin/nologin choreouser

COPY . .

RUN chown -R 10014:10014 /app

USER 10014

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

