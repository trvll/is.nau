// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.24.0
// source: answers.sql

package db

import (
	"context"
)

const createAnswer = `-- name: CreateAnswer :one
INSERT INTO answers (
    user_id,
    question_id, 
    texto,
    session_id
) VALUES (
    $1, $2, $3, $4
)
RETURNING id, user_id, question_id, texto, session_id, created_at
`

type CreateAnswerParams struct {
	UserID     int32  `json:"user_id"`
	QuestionID int32  `json:"question_id"`
	Texto      string `json:"texto"`
	SessionID  int32  `json:"session_id"`
}

func (q *Queries) CreateAnswer(ctx context.Context, arg CreateAnswerParams) (Answers, error) {
	row := q.db.QueryRowContext(ctx, createAnswer,
		arg.UserID,
		arg.QuestionID,
		arg.Texto,
		arg.SessionID,
	)
	var i Answers
	err := row.Scan(
		&i.ID,
		&i.UserID,
		&i.QuestionID,
		&i.Texto,
		&i.SessionID,
		&i.CreatedAt,
	)
	return i, err
}

const deleteAnswer = `-- name: DeleteAnswer :exec
DELETE FROM answers
WHERE id = $1
`

func (q *Queries) DeleteAnswer(ctx context.Context, id int64) error {
	_, err := q.db.ExecContext(ctx, deleteAnswer, id)
	return err
}

const getAnswer = `-- name: GetAnswer :one
SELECT id, user_id, question_id, texto, session_id, created_at FROM answers
WHERE id = $1
`

func (q *Queries) GetAnswer(ctx context.Context, id int64) (Answers, error) {
	row := q.db.QueryRowContext(ctx, getAnswer, id)
	var i Answers
	err := row.Scan(
		&i.ID,
		&i.UserID,
		&i.QuestionID,
		&i.Texto,
		&i.SessionID,
		&i.CreatedAt,
	)
	return i, err
}

const listAnswers = `-- name: ListAnswers :many
SELECT id, user_id, question_id, texto, session_id, created_at FROM answers
ORDER BY id
LIMIT $1
OFFSET $2
`

type ListAnswersParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) ListAnswers(ctx context.Context, arg ListAnswersParams) ([]Answers, error) {
	rows, err := q.db.QueryContext(ctx, listAnswers, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Answers
	for rows.Next() {
		var i Answers
		if err := rows.Scan(
			&i.ID,
			&i.UserID,
			&i.QuestionID,
			&i.Texto,
			&i.SessionID,
			&i.CreatedAt,
		); err != nil {
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

const updateAnswer = `-- name: UpdateAnswer :exec
UPDATE answers
SET texto = $2
WHERE id = $1
RETURNING id, user_id, question_id, texto, session_id, created_at
`

type UpdateAnswerParams struct {
	ID    int64  `json:"id"`
	Texto string `json:"texto"`
}

func (q *Queries) UpdateAnswer(ctx context.Context, arg UpdateAnswerParams) error {
	_, err := q.db.ExecContext(ctx, updateAnswer, arg.ID, arg.Texto)
	return err
}
