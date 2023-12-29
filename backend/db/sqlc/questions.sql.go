// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.24.0
// source: questions.sql

package db

import (
	"context"
)

const createQuestion = `-- name: CreateQuestion :one
INSERT INTO questions (
    texto
) VALUES (
    $1
)
RETURNING id, texto, created_at
`

func (q *Queries) CreateQuestion(ctx context.Context, texto string) (Questions, error) {
	row := q.db.QueryRowContext(ctx, createQuestion, texto)
	var i Questions
	err := row.Scan(&i.ID, &i.Texto, &i.CreatedAt)
	return i, err
}

const deleteQuestion = `-- name: DeleteQuestion :exec
DELETE FROM questions
WHERE id = $1
`

func (q *Queries) DeleteQuestion(ctx context.Context, id int32) error {
	_, err := q.db.ExecContext(ctx, deleteQuestion, id)
	return err
}

const getQuestion = `-- name: GetQuestion :one
SELECT id, texto, created_at FROM questions
WHERE id = $1
`

func (q *Queries) GetQuestion(ctx context.Context, id int32) (Questions, error) {
	row := q.db.QueryRowContext(ctx, getQuestion, id)
	var i Questions
	err := row.Scan(&i.ID, &i.Texto, &i.CreatedAt)
	return i, err
}

const listQuestions = `-- name: ListQuestions :many
SELECT id, texto, created_at FROM questions
ORDER BY id
LIMIT $1
OFFSET $2
`

type ListQuestionsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) ListQuestions(ctx context.Context, arg ListQuestionsParams) ([]Questions, error) {
	rows, err := q.db.QueryContext(ctx, listQuestions, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Questions
	for rows.Next() {
		var i Questions
		if err := rows.Scan(&i.ID, &i.Texto, &i.CreatedAt); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const updateQuestion = `-- name: UpdateQuestion :exec
UPDATE questions
SET texto = $2
WHERE id = $1
RETURNING id, texto, created_at
`

type UpdateQuestionParams struct {
	ID    int32  `json:"id"`
	Texto string `json:"texto"`
}

func (q *Queries) UpdateQuestion(ctx context.Context, arg UpdateQuestionParams) error {
	_, err := q.db.ExecContext(ctx, updateQuestion, arg.ID, arg.Texto)
	return err
}
