FROM tomcat:9.0-jdk17-temurin

# Remove default apps (security best practice)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR
COPY *.war /usr/local/tomcat/webapps/


