#base image
FROM golang:1.22.5 as base

#set work dir

WORKDIR /app

#copy application files

COPY go.mod ./

#download dependencies

RUN go mod download

#copy code to work dir

COPY . . 
#build application

RUN go build -o main .

#2nd stage

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]