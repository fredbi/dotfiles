#! /bin/bash
#nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync';
go install -a golang.org/x/tools/gopls@latest
go install -a golang.org/x/tools/cmd/goimports@latest
