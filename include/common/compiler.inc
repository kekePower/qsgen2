function doClang() {
	export CC=clang
	export CXX=clang++
}

function doGcc() {
	export CC=gcc
	export CXX=g++
}

function undoCompiler() {
	unset CC
	unset CXX
}
