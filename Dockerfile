FROM alpine:3.18

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

CMD ["echo", "Hello from secure Docker container inside Jenkins!"]
