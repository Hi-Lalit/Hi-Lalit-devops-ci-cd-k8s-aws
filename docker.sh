cd app
docker build -t flask-app .

docker run -d --name flask-container -p 5000:5000 flask-app
