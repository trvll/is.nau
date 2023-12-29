CONTAINER_NAME=postgres
POSTGRES_VERSION=latest
POSTGRES_USER=postgres
POSTGRES_PASSWORD=pass
POSTGRES_DB=is.nau
PORT=5432

.PHONY: start-db
start-db:
	docker run --name $(CONTAINER_NAME) \
		-e POSTGRES_USER=$(POSTGRES_USER) \
		-e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
		-e POSTGRES_DB=$(POSTGRES_DB) \
		-p $(PORT):5432 \
		-d postgres:$(POSTGRES_VERSION)

.PHONY: stop-db
stop-db:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

.PHONY: migrateup
migrateup:
	migrate -path backend/db/migration -database "postgresql://postgres:pass@localhost:5432/is.nau?sslmode=disable" -verbose up

.PHONY: migratdown
migratedown:
	migrate -path backend/db/migration -database "postgresql://postgres:pass@localhost:5432/is.nau?sslmode=disable" -verbose down

.PHONY: psql
psql:
	docker exec -it $(CONTAINER_NAME) psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

.PHONY: dropdb
dropdb:
	docker exec -it $(CONTAINER_NAME) dropdb $(POSTGRES_DB)

.PHONY: logs
logs:
	docker logs $(CONTAINER_NAME)

.PHONY: sqlc
sqlc:
	sqlc generate