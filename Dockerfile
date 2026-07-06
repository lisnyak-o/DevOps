# Використовуємо стабільний та легковаговий образ на базі Alpine (ISO 27001: мінімізація поверхні атаки)
FROM alpine:3.18

# Створюємо невибагливого користувача, щоб не запускати застосунок від імені root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

CMD ["echo", "Hello from secure Docker container inside Jenkins!"]
