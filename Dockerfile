FROM httpd
/COPY . /usr/local/apache2/htdocs/
COPY index.html /usr/local/apache2/htdocs
