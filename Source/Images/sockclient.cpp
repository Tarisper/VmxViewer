/*

=======
string 
getdatestr ()
{
SYSTEMTIME 	st;
stringstream 	sbuf;
GetLocalTime (& st);
sbuf 
<< setfill ('0') << setw (2) 		<< st.wDay 		<< "."
<< setfill ('0') << setw (2) 		<< st.wMonth 		<< "."
<< setfill ('0') << setw (4) 		<< st.wYear 		<< " "
<< setfill ('0') << setw (2) 		<< st.wHour 		<< ":"
<< setfill ('0') << setw (2) 		<< st.wMinute 	<< ":"
<< setfill ('0') << setw (2) 		<< st.wSecond 	<< "."
<< setfill ('0') << setw (3)		<< st.wMilliseconds;
return sbuf.str();
}

*/

# define WIN32_LEAN_AND_MEAN

# include <windows.h>
# include <winsock2.h>
# include <ws2tcpip.h>
# include <stdlib.h>
# include <stdio.h>

# include  <string>

// Need to link with Ws2_32.lib, Mswsock.lib, and Advapi32.lib
# pragma comment (lib, "Ws2_32.lib")
# pragma comment (lib, "Mswsock.lib")
# pragma comment (lib, "AdvApi32.lib")


# define DEFAULT_PORT "27015"
# define DEFAULT_BUFLEN  512
# define L  32
# define BL  32

typedef  unsigned int 	Uint32;

struct  tini  
{
	int 		verify;
	char 	hostname[256];
} ;

// timers
struct  tcarets  
{
	int 	data;			// sensor data caret
	int 	sendlast;		// 
	int 	send;			// 
};

struct  ttimer 
{
	int 	tm;	// write timer
	int 	tmo;	// write timeout
};

struct addrinfo 	hints;
SOCKET 		ConnectSocket = INVALID_SOCKET;

/* ============================================ */

void  cycle1  ( int & k,  int  limit ) 
{
	k++ ;
	if  (k > limit)  k = 0; 
}

int  sockinit (	char*  hostname )
{
	WSADATA 		wsaData;
	struct addrinfo* 	result = NULL;
	struct addrinfo* 	ptr = NULL;
	int 	iResult;

	// Initialize Winsock
	iResult = WSAStartup ( MAKEWORD ( 2, 2 ),  & wsaData );
	if  ( iResult != 0 ) {
		printf ("WSAStartup failed with error: %d\n", iResult);
		return 1;
	}

	ZeroMemory ( & hints, sizeof (hints) );
	// hints.ai_family = AF_UNSPEC;
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_protocol = IPPROTO_TCP;

	// Resolve the server address and port
	iResult = getaddrinfo ( hostname, DEFAULT_PORT,  & hints, & result );
	if  ( iResult != 0 ) {
		printf ("getaddrinfo failed with error: %d\n", iResult);
		WSACleanup ();
		return 1;
	}

	// Attempt to connect to an address until one succeeds
	// Create a SOCKET for connecting to server
	ConnectSocket = INVALID_SOCKET;	// reset value
	ptr = result;

	ConnectSocket = socket ( ptr-> ai_family,  ptr-> ai_socktype,  ptr-> ai_protocol);
	if  ( ConnectSocket == INVALID_SOCKET) {
		printf ("socket failed with error: %ld\n", WSAGetLastError());
		WSACleanup ();
		return 1;
	}
	// Connect to server.
	iResult = connect ( ConnectSocket,  ptr-> ai_addr,  (int)ptr-> ai_addrlen );
	if  ( iResult == SOCKET_ERROR ) {
		printf ("socket connect failed, error: %ld\n", WSAGetLastError());
		closesocket ( ConnectSocket );
		ConnectSocket = INVALID_SOCKET;
	}
	freeaddrinfo ( result );

	if  ( ConnectSocket == INVALID_SOCKET ) {
		printf ("Unable to connect to server!\n");
		WSACleanup();
		return 1;
	}

	return 0;
} 


/*  main()
==========================================
==========================================
==========================================
==========================================
*/


int  __cdecl main  (int argc, char **argv) 
{

tini		ini;
int  	err = 0;
int  	arv = 0;		// app return value7


if  ( argc != 2) {
	printf ("usage: %s server-name \n", argv[0]);
	return 1; 
}

/*init section*/
strcpy  ( ini . hostname, argv[1]);
ini.verify = false;
for ( int i = 0 ;; ) {
	packet [i] = i;
	// printf ( "byte %d  value %d \n",  i,  (int)packet[i] );
	i++;
	if  ( i == L )  break;
}

arv = sockinit ( & ini.hostname[0] );		// 0 = success
if  ( arv > 0 )  {
	printf ("init failed, closing \n");
	return arv; 
}

/*
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
*/

ttimers  timerdata;
timerdata.tm = 0;
timerdata.to = 10 ;
tcarets	crt;
char 	recvbuf [DEFAULT_BUFLEN];
int 		recvbuflen = DEFAULT_BUFLEN;
char 	packetbuf [BL][L];
char*	ppacket;		// pointer to current packet
int	k;		//  current send packet index
// char*	packet;
// char 	packet [L];

Uint32 send_count = 0;
Uint32 loop_count = 0;
int  	send_sleep = 5000;
int 	iResult;
int 	locksend = 0;		// sender state
// int 	locksend = 0;		// sender state
DWORD prevTime = GetTickCount();
DWORD passedTime = 0;

// printf ( "sizeof(int) =  %d\n", (int) sizeof (int)  );
printf (" ================= \n ");

for (;;) {
	printf (" ==== loop %d\n ", loop_count);
	/* send data */
	if  ( locksend == 0 ) {
		printf ( " sending... %d\n", send_count );
		memcpy ( & packetbuf[k][0],  & k,  sizeof(int) );
		// memcpy ( & packet[0],  (void*) & send_count,  sizeof(int) );
		// iResult = send ( ConnectSocket, & packet[0], L, 0 );
		iResult = send ( ConnectSocket, & packet[0], L, 0 );
		send_count ++;
	}
	if  ( locksend == 1 ) {
		// if  ( response_err == 1 ) {
		if  ( resend == 1 ) {
			iResult = send ( ConnectSocket, & packet[0], L, 0 );

		} 
	}
	locksend = 1; 		// disable send
	if  ( iResult == SOCKET_ERROR ) {
		arv = 1;
		break;
	}
	
	/* get response packet from server */
	if  ( ini.verify == true ) {
		iResult = recv ( ConnectSocket, recvbuf, recvbuflen, 0 );
		if  ( iResult > 0 ) {
			printf ("response received: %d bytes\n", iResult);
		} 
		if  ( iResult == 0 ) {
			printf ("Connection closed\n");
			arv = 0;
			break;
		}
		if  ( iResult < 0 ) {
			// printf ("recv failed with error: %d\n", WSAGetLastError());
			arv = 1;
			break;
		}
	}
	
	// loop state 
	locksend = 0; 		// disable send
	loop_count++;
	Sleep ( send_sleep );
	
	passedTime = GetTickCount() - prevTime;
	if  ( play ) {
		// cycle1 ( k,  sequence_size - 1 );
		timer_db += passedTime;
		timer_f += passedTime;		
	}
	prevTime = GetTickCount(); 			// read loop time ms
	
}

err = WSAGetLastError();
printf ( "send failed with error: %d\n", err );

/*
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
*/

// shutdown the connection for sending since no more data will be sent
// the client can still use the ConnectSocket for receiving data
iResult = shutdown (ConnectSocket, SD_SEND);
if  ( iResult == SOCKET_ERROR ) {
	printf ("shutdown failed with error: %d\n", WSAGetLastError());
	arv = 1;
}

// cleanup
closesocket (ConnectSocket);
WSACleanup();

return arv;
}
