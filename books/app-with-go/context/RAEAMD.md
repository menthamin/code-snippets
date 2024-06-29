# Execute
go run main.go using_go_routine_with_wg.go what_is_context.go

# Execute after build package

## Directory structure
```
.
├── main.go
├── using_go_routine_with_wg.go
└── what_is_context.go
```

```bash

# build and run
go build -o myprogram
./myprogram

# init module
go mod init mymodule
> go: creating new go.mod: module mymodule
> go: to add module requirements and sums:
>        go mod tidy
go mod tidy

# run
go run .
```

