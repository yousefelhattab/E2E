# Use Golang image based on Alpine
FROM golang:1.18-alpine

# Install git (required for Go module initialization)
RUN apk add --no-cache git

# Set working directory
WORKDIR /app

# Copy the application source code
COPY . .

# Initialize Go module with a basic path
RUN go mod init example.com/lightweight-go-app && go mod tidy

# Build the Go application
RUN go build -o app .

# Expose port 3000
EXPOSE 3000

# Run the application
CMD ["./app"]
