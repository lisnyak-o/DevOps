FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

USER appuser

CMD ["echo", "Hello from secure Docker container inside Jenkins!"]
