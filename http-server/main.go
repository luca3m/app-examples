package main

import (
	"net/http"
	"log"
)

func main() {
	http.HandleFunc("/ping", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("pong"))
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
