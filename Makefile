# change if needed
CNAME=ts3-server
VOLUME=/data/dockers/${CNAME}
VIRTUAL_VOICE_PORT=9987
SERVER_QUERY_PORT=10011
FILE_TRANSFER_PORT=30033
INAME=fingerland-asso/${CNAME}

# computed data
SERVICE_ENV_FILE=${PWD}/${CNAME}.env
SERVICE_FILE=${PWD}/${CNAME}.service
OPTIONS=-v ${VOLUME}:/home/teamspeak/data -p ${VIRTUAL_VOICE_PORT}:9987/udp -p ${FILE_TRANSFER_PORT}:30033 -p ${SERVER_QUERY_PORT}:10011

help:
	@echo "Fingerland Teamspeak server (docker builder)"

build:
	@docker build -t ${INAME} .


volume:
	@sudo mkdir -p ${VOLUME}
	@sudo chown -R 1000:1000 ${VOLUME}

systemd-service:
	@echo "CNAME=${CNAME}" > ${SERVICE_ENV_FILE}
	@echo "VOLUME=${VOLUME}" >> ${SERVICE_ENV_FILE}
	@echo "VIRTUAL_VOICE_PORT=${VIRTUAL_VOICE_PORT}" >> ${SERVICE_ENV_FILE}
	@echo "SERVER_QUERY_PORT=${SERVER_QUERY_PORT}" >> ${SERVICE_ENV_FILE}
	@echo "FILE_TRANSFER_PORT=${FILE_TRANSFER_PORT}" >> ${SERVICE_ENV_FILE}
	@cp service.sample ${SERVICE_FILE}
	@sed -i -e "s;EnvironmentFile=.*$$;EnvironmentFile=${SERVICE_ENV_FILE};" ${SERVICE_FILE}
	@sudo systemctl enable ${SERVICE_FILE}

run: volume
	@docker run -ti --restart=always ${OPTIONS} ${INAME}

create:
	@docker create --name=${CNAME} --restart=always -ti ${OPTIONS} ${INAME}

start: create
	@docker start ${CNAME}

stop:
	@docker stop ${CNAME}
