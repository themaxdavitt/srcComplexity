# Build for srcComplexity

all : srcComplexity srcComplexity.1 srcComplexity.1.html

srcComplexity : srcComplexity.o srcMLXPathCount.o
	g++ srcComplexity.o srcMLXPathCount.o -lxml2 -o srcComplexity

srcComplexity.o : srcComplexity.cpp srcMLXPathCount.hpp
	g++ -I/usr/include/libxml2 -c srcComplexity.cpp

srcMLXPathCount.o : srcMLXPathCount.cpp srcMLXPathCount.hpp
	g++ -I/usr/include/libxml2 -c srcMLXPathCount.cpp

.PHONY: doc
doc : srcComplexity.1 srcComplexity.1.html

srcComplexity.1: srcComplexity.1.md
	ronn --pipe --roff srcComplexity.1.md > srcComplexity.1

srcComplexity.1.html: srcComplexity.1.md
	ronn --pipe --html srcComplexity.1.md > srcComplexity.1.html

.PHONY: run
run : srcComplexity
	./srcComplexity srcMLXPathCount.cpp.xml

.PHONY: clean
clean :
	rm -f srcComplexity srcComplexity.o srcMLXPathCount.o \
		srcComplexity.1 srcComplexity.1.html
