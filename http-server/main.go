package main

import (
	"net/http"
	"log"
	"math/rand"
	"time"
)

func main() {
	http.HandleFunc("/ping", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("pong"))
	})
	http.HandleFunc("/random_wait", func(w http.ResponseWriter, r *http.Request) {
		time.Sleep(time.Duration((rand.Int() % 10)) * time.Millisecond)
	})
	http.HandleFunc("/hello/", func(w http.ResponseWriter, r *http.Request) {
		name := r.URL.Path[len("/hello/"):]
		time.Sleep(100 * time.Millisecond)
		w.Write([]byte("hello " + name))
	})
	log.Fatal(http.ListenAndServe(":8080", nil))
}
