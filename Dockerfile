FROM fukamachi/sbcl:2.2.8-alpine AS builder

WORKDIR /app
RUN apk add sqlite-dev git
RUN ros install qlot
COPY ./areyougoogle.lisp ./areyougoogle.ros ./areyougoogle.asd ./qlfile ./qlfile.lock ./
RUN qlot install
RUN qlot exec ros build areyougoogle.ros
ENTRYPOINT ["./areyougoogle", "-s"]

# FROM alpine:latest
# RUN apk add sqlite-dev zstd-dev
# WORKDIR /app
# COPY --from=builder /app/.qlot ./.qlot
# COPY --from=builder /app/areyougoogle ./
# ENTRYPOINT ["./areyougoogle", "-s"]
# EXPOSE 8080
