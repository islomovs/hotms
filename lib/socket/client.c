#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <sys/sendfile.h>
#include <sys/stat.h>
#include <fcntl.h>

#define PORT 5555
#define MAXDATASIZE 2500

// HOSPITALS APIS

void createQueue(int sockfd, const char *jwtToken, const char *name);
void appointOperationToAnyPatient(int sockfd, const char *jwtToken, const char *doctorName, const char *doctorRole,
    const char *time, const char *patientId, const char *donorId);
void appointOperationByTheQueue(int sockfd, const char *jwtToken, const char *doctorName, const char *doctorRole,
    const char *time, const char *donorId);
void cancelOperation(int sockfd, const char* jwtToken, const char* operationId);

// DONORS AND PATIENTS APIS

void applyToHospital(int sockfd, const char* jwtToken, const char *hospitalId);
void applyToDispensary(int sockfd, const char* jwtToken, const char* dispensaryId, const char* phone);

// DISPENSARY APIS

void assignDateForPatientsAppointment(int sockfd, const char* jwtToken, const char* patientId, const char* time);
void assignDateForDonorsAppointment(int sockfd, const char* jwtToken, const char* donorId, const char* time);

void sendLoginRequest(int sockfd, const char *email, const char *password);
void sendSignupRequest(int sockfd, const char *fullName, const char *email, const char *password, const char *rePassword, const char *role);
void sendGetMyInfoRequest(int sockfd, const char *jwtToken);

int main(int argc, char *argv[]) {

    int sockfd, num;
    char buf[MAXDATASIZE];
    struct hostent *he;
    struct sockaddr_in server;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s <IP Address>\n", argv[0]);
        exit(1);
    }

    if ((he = gethostbyname(argv[1])) == NULL) {
        perror("gethostbyname");
        exit(1);
    }

    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }

    server.sin_family = AF_INET;
    server.sin_port = htons(PORT);
    server.sin_addr = *((struct in_addr *)he->h_addr);
    bzero(&(server.sin_zero), 8);

    if (connect(sockfd, (struct sockaddr *)&server, sizeof(struct sockaddr)) == -1) {
        perror("connect");
        exit(1);
    }
    
    // HOSPITALS APIS
    
    if (argc == 5 && strcmp(argv[2], "createQueue") == 0) {
    	printf("\nr s");
    	createQueue(sockfd, argv[3], argv[4]);
    	printf("\n r e\n");
    }	

    if (argc == 9 && strcmp(argv[2], "appointOperationToAnyPatient") == 0) {
        printf("\nr s");
        appointOperationToAnyPatient(sockfd, argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
        printf("\n r e\n");
    }

    if (argc == 8 && strcmp(argv[2], "appointOperationByTheQueue") == 0) {
        printf("\nr s");
        appointOperationByTheQueue(sockfd, argv[3], argv[4], argv[5], argv[6], argv[7]);
        printf("\n r e\n");
    }

    if (argc == 5 && strcmp(argv[2], "cancelOperation") == 0) {
        printf("\nr s");
        cancelOperation(sockfd, argv[3], argv[4]);
        printf("\nr e\n");
    }

    // DONORS AND PATIENTS APIS

    if (argc == 5 && strcmp(argv[2], "applyToHospital") == 0) {
        printf("\nr s");
        applyToHospital(sockfd, argv[3], argv[4]);
        printf("\n r e\n");
    }

    if (argc == 6 && strcmp(argv[2], "applyToDispensary") == 0) {
        printf("\nr s");
        applyToDispensary(sockfd, argv[3], argv[4], argv[5]);
        printf("\n r e\n");
    }

    // DISPENSARY APIS

    if (argc == 6 && strcmp(argv[2], "assignDateForPatientsAppointment") == 0) {
        printf("\nr s");
        assignDateForPatientsAppointment(sockfd, argv[3], argv[4], argv[5]);
        printf("\n r e\n");
    }

    if (argc == 6 && strcmp(argv[2], "assignDateForDonorsAppointment") == 0) {
        printf("\nr s");
        assignDateForDonorsAppointment(sockfd, argv[3], argv[4], argv[5]);
        printf("\n r e\n");
    }

    // AUTHENTICATION APIS

    // Check for additional command-line arguments for login
    if (argc == 5 && strcmp(argv[2], "login") == 0) {
        sendLoginRequest(sockfd, argv[3], argv[4]);
    }

    // Check for additional command-line arguments for signup
    if (argc == 8 && strcmp(argv[2], "signup") == 0) {
    	printf("\nCalling signUp request\n");
        sendSignupRequest(sockfd, argv[3], argv[4], argv[5], argv[6], argv[7]);
        printf("Request completed\n");
    }
    
    // Check for additional command-line arguments for token request
    if (argc == 4 && strcmp(argv[2], "getMyInfo") == 0) {
    	printf("\nMyInfo request");
        sendGetMyInfoRequest(sockfd, argv[3]);
        printf("\nEnded\n");
    }


    if ((num = recv(sockfd, buf, MAXDATASIZE, 0)) == -1) {
        perror("recv");
        exit(1);
    }

    buf[num] = '\0'; // Set null terminator based on the number of received bytes
    printf("server message: %s\n", buf);
    close(sockfd);

    return 0;
}

// HOSPITALS APIS

void createQueue(int sockfd, const char *jwtToken, const char *name) {
    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "createQueue \"%s\" \"%s\"", jwtToken, name);
    
    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

void appointOperationToAnyPatient(int sockfd, const char* jwtToken, const char* doctorName, const char* doctorRole,
    const char* time, const char* patientId, const char* donorId) {

    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "appointOperationToAnyPatient \"%s\" \"%s\" \"%s\" %s %s %s", jwtToken, doctorName, doctorRole, time, patientId, donorId);

    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

void cancelOperation(int sockfd, const char* jwtToken, const char* operationId) {

    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "cancelOperation \"%s\" %s", jwtToken, operationId);

    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

void appointOperationByTheQueue(int sockfd, const char* jwtToken, const char* doctorName, const char* doctorRole,
    const char* time, const char* donorId) {

    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "appointOperationByTheQueue \"%s\" \"%s\" \"%s\" %s %s", jwtToken, doctorName, doctorRole, time, donorId);

    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

// DONORS AND PATIENTS APIS

void applyToHospital(int sockfd, const char* jwtToken, const char* hospitalId) {
    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "applyToHospital \"%s\" %s", jwtToken, hospitalId);

    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

void applyToDispensary(int sockfd, const char* jwtToken, const char* dispensaryId, const char* phone) {
    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "applyToDispensary \"%s\" %s \"%s\"", jwtToken, dispensaryId, phone);

    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

// DISPENSARY APIS

void assignDateForPatientsAppointment(int sockfd, const char* jwtToken, const char* patientId, const char* time) {
    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "assignDateForPatientsAppointment \"%s\" %s %s", jwtToken, patientId, time);

    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

void assignDateForDonorsAppointment(int sockfd, const char* jwtToken, const char* donorId, const char* time) {
    printf("\nReached");
    char createRequest[MAXDATASIZE];
    snprintf(createRequest, MAXDATASIZE, "assignDateForDonorsAppointment \"%s\" %s %s", jwtToken, donorId, time);

    if (send(sockfd, createRequest, strlen(createRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

// AUTHENTICATION APIS

void sendLoginRequest(int sockfd, const char *email, const char *password) {
    char loginRequest[MAXDATASIZE];
    snprintf(loginRequest, MAXDATASIZE, "login %s %s", email, password);

    // Send the login request to the server
    if (send(sockfd, loginRequest, strlen(loginRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}

void sendSignupRequest(int sockfd, const char *fullName, const char *email, const char *password, const char *rePassword, const char *role) {
    char signupRequest[MAXDATASIZE];
    snprintf(signupRequest, MAXDATASIZE, "signup \"%s\" %s %s %s %s", fullName, email, password, rePassword, role);
    printf("\nReached Here! %s, %s, %s, %s, %s ", fullName, email, password, rePassword, role);

    printf("\nSending signup request: %s\n", signupRequest); // Print the request being sent

    // Send the signup request to the server
    if (send(sockfd, signupRequest, strlen(signupRequest), 0) == -1) {
        perror("send");     
        exit(1);
    }

    printf("\nSignup request sent\n"); // Print a message after the request is sent
}

void sendGetMyInfoRequest(int sockfd, const char *jwtToken) {
    char getMyInfoRequest[MAXDATASIZE];
    snprintf(getMyInfoRequest, MAXDATASIZE, "getMyInfo \"%s\"", jwtToken);

    // Send the getInfo request to the server
    if (send(sockfd, getMyInfoRequest, strlen(getMyInfoRequest), 0) == -1) {
        perror("send");
        exit(1);
    }
}
