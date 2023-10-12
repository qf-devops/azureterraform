#! /bin/bash
sudo apt update
sudo apt install nginx -y
cd /var/www
sudo mkdir tutorial
cd tutorial
sudo cat > index.html << EOL
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hello, Nginx!</title>
</head>
<body>
    <h1>Hello, Nginx!</h1>
    <p>We have just configured our Nginx web server on Ubuntu Server!</p>
</body>
</html>
EOL
cd /etc/nginx/sites-enabled
sudo cat > tutorial << EOL
server {
       listen 81;
       listen [::]:81;

       server_name example.ubuntu.com;

       root /var/www/tutorial;
       index index.html;

       location / {
               try_files $uri $uri/ =404;
       }
}
EOL
sudo service nginx restart