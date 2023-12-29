package models

type User struct {
    ID       int
    Username string
    Password string // Armazenar o hash da senha, não a senha em texto puro
    Email    string
}