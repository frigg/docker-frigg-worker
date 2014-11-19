all: setup run

worker.yaml:
	@echo "Redis-host: ";\
	 read redis_host;\
	 echo "Redis-port: ";\
	 read redis_port;\
	 echo "Redis-password: ";\
	 read redis_pw;\
	 echo "Redis-db: ";\
	 read redis_db;\
	 echo "hq-domain: ";\
	 read domain;\
	 echo "hq-token: ";\
	 read token;\
	 echo "Sentry DSN: ";\
	 read sentry_dsn;\
	 echo "HQ_REPORT_URL: $$domain/api/workers/report/" > worker.yaml;\
	 echo "TOKEN: $$token"                             >> worker.yaml;\
	 echo "REDIS:"                                     >> worker.yaml;\
	 echo "  host: $$redis_host"                       >> worker.yaml;\
	 echo "  port: $$redis_port"                       >> worker.yaml;\
	 echo "  password: $$redis_pw"                     >> worker.yaml;\
	 echo "  db: $$redis_db"                           >> worker.yaml;\
	 echo "SENTRY_DSN: $$sentry_dsn"                   >> worker.yaml

setup: worker.yaml
	docker build -t worker .

run:
	docker run -i worker 2>&1 > worker.log &

killall:
	docker kill $(docker ps | grep worker | awk '{print $1}')

.PHONY: setup run
