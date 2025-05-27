FROM alpine:latest

# Install bash and ttyd
RUN apk add --no-cache bash ttyd

# Expose port 8080 (ttyd default)
EXPOSE 8080

# Run ttyd serving bash shell on port 8080
CMD ["ttyd", "-p", "8080", "bash"]
