.PHONY: Main.main

default: smlnj

all: smlnj mlton

mlton: main

FILES = \
cont-mlton.sml \
util.sml \
region.sml \
operators.sml \
parser/ast.sml \
parser/timl.grm \
parser/timl.lex \
parser/parser.sml \
bind.sml \
var-uvar.sml \
expr.sml \
uvar-expr.sml \
elaborate.sml \
name-resolve.sml \
trivial-solver.sml \
nouvar-expr.sml \
vc.sml \
bigO-solver.sml \
typecheck.sml \
post-typecheck.sml \
sexp/sexp.sml \
sexp/sexp.grm \
sexp/sexp.lex \
sexp/parser.sml \
smt2-printer.sml \
smt-solver.sml \
main.sml \
mlton-main.sml \

main: main.mlb $(FILES)
	mlyacc parser/timl.grm
	mllex parser/timl.lex
	mlyacc sexp/sexp.grm
	mllex sexp/sexp.lex
	mlton $(MLTON_FLAGS) main.mlb

profile:
	mlprof -show-line true -raw true main mlmon.out

smlnj: main.cm
	./format.rb ml-build -Ccompiler-mc.error-non-exhaustive-match=true -Ccompiler-mc.error-non-exhaustive-bind=true main.cm Main.main main-image

clean:
	rm main
	rm main-image*