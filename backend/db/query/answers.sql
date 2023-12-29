-- name: CreateAnswer :one
INSERT INTO answers (
    user_id,
    question_id, 
    texto,
    session_id
) VALUES (
    $1, $2, $3, $4
)
RETURNING *;

-- name: GetAnswer :one
SELECT * FROM answers
WHERE id = $1;

-- name: ListAnswers :many
SELECT * FROM answers
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateAnswer :exec
UPDATE answers
SET texto = $2
WHERE id = $1
RETURNING *;

-- name: DeleteAnswer :exec
DELETE FROM answers
WHERE id = $1;
