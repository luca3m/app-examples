#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/syscall.h>
#include <vector>
#include <sys/prctl.h>
#include <thread>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <functional>
#include <mutex>
#include <condition_variable>
#include <sys/stat.h>

using namespace std; 

void do_nothing()
{
	while(true)
	{
		sleep(1);
	}
}

void open_files(int k, int nfiles)
{
	vector<FILE*> fv;
	for(int j = 0; j < nfiles; ++j)
	{
		char path[50];
		snprintf(path, 50, "/tmp/xxx%d-%d", k, j);
		fv.emplace_back(fopen(path, "w"));
	}
}

void open_fifos(int k, int nfifos)
{
	vector<int> fv;
	for(int j = 0; j < nfifos; ++j)
	{
		char path[50];
		snprintf(path, 50, "/tmp/xxy%d-%d", k, j);
		fv.emplace_back(mkfifo(path, 0));
	}
}

class connections
{
public:
	connections(){}
	int create(int nconns)
	{
		struct sockaddr_in server_address;
		memset(&server_address, 0, sizeof(server_address));     /* Zero out structure */
		server_address.sin_family      = AF_INET;             /* Internet address family */
		server_address.sin_addr.s_addr = 0x0100007F;   /* Server IP address */
		server_address.sin_port        = htons(7);

		for(int j = 0; j < nconns; ++j)
		{
			auto sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
			auto res = connect(sock, (struct sockaddr *) &server_address, sizeof(server_address));
			if(res == 0)
			{
				m_sockets.emplace_back(sock);
			}
		}
	}

	int run_with_sock()
	{
		static const char* payload = "test";
		static const auto payload_length = sizeof("test")-1;
		char* buffer[200];

		int sock = 0;
		{
			unique_lock<mutex> lock(m_mutex);
			if(m_sockets.size() == 0)
			{
				m_cv.wait(lock, [&]() { return m_sockets.size() > 0; } );
			}
			auto it = m_sockets.begin();
			sock = *it;
			m_sockets.erase(it);
		}
		send(sock, payload, payload_length, 0);
		recv(sock, buffer, sizeof(buffer), 0);
		{
			lock_guard<mutex> lock(m_mutex);
			m_sockets.emplace_back(sock);
			m_cv.notify_one();
		}
	}
private:
	vector<int> m_sockets;
	mutex m_mutex;
	condition_variable m_cv;
};

int run_threads(int i, int nthreads, int nfiles, connections& conns)
{
	vector<unique_ptr<thread>> tt;
	for(int k = 0; k < nthreads; ++k)
	{
		tt.emplace_back(new thread([&](){
			while(true)
			{
				conns.run_with_sock();
				usleep(500000);
			}
		}));
	}
	for(int k = 0; k < nthreads; ++k)
	{
		tt[k]->join();
	}
	return 0;
}

int main(int argc, char **argv)
{
	auto nprocs = atoi(argv[1]);
	auto nthreads = atoi(argv[2])/nprocs;
	auto nfiles = atoi(argv[3])/nprocs;
	auto nconns = atoi(argv[4])/nprocs;
	auto nfifos = argc > 5 ? atoi(argv[5])/nprocs : 0;
	for (int j = 0; j < nprocs; ++j)
	{
		auto pid = fork();
		if (pid == 0)
		{
			prctl(PR_SET_PDEATHSIG, SIGKILL);
			connections conns;
			conns.create(nconns);
			open_files(j, nfiles);
			open_fifos(j, nfifos);
			return run_threads(j, nthreads, nfiles, conns);
		}
	}
	for (int j = 0; j < nprocs; ++j)
	{
		wait(NULL);
	}
	return 0;
}