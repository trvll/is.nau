-- name: CreateSession :one
INSERT INTO sessions (user_id, current_question_id) VALUES ($1, $2) RETURNING *;

-- name: GetSession :one
SELECT * FROM sessions WHERE id = $1;

-- name: ListSessions :many
SELECT * FROM sessions ORDER BY id LIMIT $1 OFFSET $2;

-- name: UpdateSession :exec
UPDATE sessions SET current_question_id = $2 WHERE id = $1 RETURNING *;

-- name: DeleteSession :exec
DELETE FROM sessions WHERE id = $1;
