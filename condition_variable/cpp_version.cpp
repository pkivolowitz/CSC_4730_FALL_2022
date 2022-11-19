#include <iostream>
#include <mutex>
#include <thread>
#include <vector>
#include <condition_variable>
#include <getopt.h>

using namespace std;

int done = 0;
mutex m;
condition_variable cv;

void child0() {
	m.lock();
	cout << "child0\n";
	done = 1;
	cv.notify_one();
	m.unlock();
}

void child1() {
	m.lock();
	cout << "child1\n";
	cv.notify_one();
	m.unlock();
}

void thr_join0() {
	unique_lock<mutex> lk(m);
	while (done == 0) {
		cv.wait(lk);
	}
}

void thr_join1() {
	unique_lock<mutex> lk(m);
	cv.wait(lk);
}


int main(int argc, char *argv[]) { 
	int c;
	int mode = 0;
	int counter = 0;
	
	while ((c = getopt(argc, argv, "m:")) != -1) {
		switch (c) {
			case 'm':
				mode = atoi(optarg);
				break;

			default:
				printf("Bad option -  usage: prog -m MODENUM\n");
				exit(1);
		}
	}
	if (mode < 0 || mode > 1) {
		cerr << "Mode " << mode << " is not 0 or 1\n";
		exit(1);
	}

	thread * p = nullptr;

	void (* child[2])() = { child0, child1 };
	void (* joins[2])() = { thr_join0, thr_join1 };

	cout << (!mode ? "This version is correct. It will NOT hang.\n" : "This version may hang\n");
	cout << "Hit enter to begin.\nHit ^C to terminate.\n";
	cin.get();
	while (1) {
		cout << "parent: begin - iteration: " << ++counter << endl;
		p = new thread(child[mode]);
		joins[mode]();
		p->join();
		delete p;
		printf("parent: end\n");
	}

	return 0;
}
