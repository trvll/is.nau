-- name: CreateQuestion :one
INSERT INTO questions (texto) VALUES ($1) RETURNING *;

-- name: GetQuestion :one
SELECT * FROM questions WHERE id = $1;

-- name: ListQuestions :many
SELECT * FROM questions ORDER BY id LIMIT $1 OFFSET $2;

-- name: UpdateQuestion :exec
UPDATE questions SET texto = $2 WHERE id = $1 RETURNING *;

-- name: DeleteQuestion :exec
DELETE FROM questions WHERE id = $1;
