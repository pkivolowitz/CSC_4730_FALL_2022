CPPFLAGS	= -Wall -std=c++11 -O3
CFLAGS 		= -Wall -O3
CXX			= g++
CC			= gcc

all			: pthread cppversion

pthread		: 	pthread_version.c
			$(CC) $(CFLAGS) -o $@ $< -lpthread

cppversion	:	cpp_version.cpp 
			$(CXX) $(CPPFLAGS) -o $@ $<

clean		:
			rm -f *.o cppversion pthread 
			rm -rf pthread.dSYM
