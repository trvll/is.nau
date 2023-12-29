-- name: CreateSessionProgress :one
INSERT INTO session_progress (session_id, question_id, is_answered, answered_at) 
VALUES ($1, $2, $3, $4) RETURNING *;

-- name: GetSessionProgress :one
SELECT * FROM session_progress WHERE id = $1;

-- name: ListSessionProgress :many
SELECT * FROM session_progress ORDER BY id LIMIT $1 OFFSET $2;

-- name: UpdateSessionProgress :exec
UPDATE session_progress SET is_answered = $2, answered_at = $3 
WHERE id = $1 RETURNING *;

-- name: DeleteSessionProgress :exec
DELETE FROM session_progress WHERE id = $1;
