# Use the official Tomcat image as the base image
FROM tomcat:9.0-jdk8-openjdk

# Author
LABEL maintainer="Your Name <your.email@example.com>"

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Expose Tomcat default port
EXPOSE 8080

# Copy your war file into the webapps directory
ADD ./target/ROOT.war $CATALINA_HOME/webapps/

# Start Tomcat
CMD ["catalina.sh", "run"]
