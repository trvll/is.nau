CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "username" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "created_at" timestamp with time zone NOT NULL DEFAULT (now())
);

CREATE TABLE "questions" (
  "id" bigserial PRIMARY KEY,
  "texto" text NOT NULL,
  "created_at" timestamp with time zone NOT NULL DEFAULT (now())
);

CREATE TABLE "answers" (
  "id" bigserial PRIMARY KEY,
  "user_id" int NOT NULL,
  "question_id" int NOT NULL,
  "texto" text NOT NULL,
  "session_id" int NOT NULL,
  "created_at" timestamp with time zone NOT NULL DEFAULT (now())
);

CREATE TABLE "sessions" (
  "id" bigserial PRIMARY KEY,
  "user_id" int NOT NULL,
  "current_question_id" int,
  "started_at" timestamp with time zone NOT NULL DEFAULT (now()),
  "completed_at" timestamp with time zone
);

CREATE TABLE "session_progress" (
  "id" bigserial PRIMARY KEY,
  "session_id" int NOT NULL,
  "question_id" int NOT NULL,
  "is_answered" boolean NOT NULL DEFAULT false,
  "answered_at" timestamp with time zone
);

CREATE INDEX "idx_users_username" ON "users" ("username");

CREATE INDEX "idx_users_email" ON "users" ("email");

CREATE INDEX "idx_answers_user_id" ON "answers" ("user_id");

CREATE INDEX "idx_answers_question_id" ON "answers" ("question_id");

CREATE INDEX "idx_sessions_user_id" ON "sessions" ("user_id");

CREATE INDEX "idx_session_progress" ON "session_progress" ("session_id", "question_id");

ALTER TABLE "answers" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "answers" ADD FOREIGN KEY ("question_id") REFERENCES "questions" ("id");

ALTER TABLE "answers" ADD FOREIGN KEY ("session_id") REFERENCES "sessions" ("id");

ALTER TABLE "sessions" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "sessions" ADD FOREIGN KEY ("current_question_id") REFERENCES "questions" ("id");

ALTER TABLE "session_progress" ADD FOREIGN KEY ("session_id") REFERENCES "sessions" ("id");

ALTER TABLE "session_progress" ADD FOREIGN KEY ("question_id") REFERENCES "questions" ("id");
