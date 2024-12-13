package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Hello, Yousef Elhattab 🚀")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Server running on http://localhost:3000")
    http.ListenAndServe(":3000", nil)
}
