#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <curl/curl.h>
#include <sys/sendfile.h>
#include <sys/stat.h>
#include <fcntl.h>

#define PORT 5555
#define MAXDATASIZE 2500

size_t writeCallback(void *contents, size_t size, size_t nmemb, char *output) {
    // Write the received data to the provided buffer
    strcat(output, (char *)contents);
    return size * nmemb;
}

// HOSPITALS APIS

void handleCreateQueue(int new_fd, const char *jwtToken, const char *name) {
    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/hospitals/createQueue");

    // Initialize libcurl
    CURL *curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
	struct curl_slist *headers = NULL;
	headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

	// Set the authorization header
	char authorizationHeader[MAXDATASIZE];
	snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
	headers = curl_slist_append(headers, authorizationHeader);

	// Prepare the POST data
	char postData[MAXDATASIZE];
	snprintf(postData, MAXDATASIZE, "name=%s", name);

	// Set libcurl options
	curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
	curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    } 
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleAppointOperationToAnyPatient(int new_fd, const char* jwtToken, const char* doctorName, const char* doctorRole,
    const char* time, const char* patientId, const char* donorId) {

    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/hospitals/appointOperationToAnyPatient");

    // Initialize libcurl
    CURL* curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist* headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Set the authorization header
        char authorizationHeader[MAXDATASIZE];
        snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authorizationHeader);

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "doctorName=%s&doctorRole=%s&time=%s&patientId=%s&donorId=%s", doctorName, doctorRole, time, patientId, donorId);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }
        else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleAppointOperationByTheQueue(int new_fd, const char* jwtToken, const char* doctorName, const char* doctorRole,
    const char* time, const char* donorId) {

    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/hospitals/appointOperationByTheQueue");

    // Initialize libcurl
    CURL* curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist* headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Set the authorization header
        char authorizationHeader[MAXDATASIZE];
        snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authorizationHeader);

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "doctorName=%s&doctorRole=%s&time=%s&donorId=%s", doctorName, doctorRole, time, donorId);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }
        else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleCancelOperation(int new_fd, const char* jwtToken, const char* operationId) {
    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/hospitals/cancelOperation");

    // Initialize libcurl
    CURL* curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the DELETE parameters
        struct curl_slist* headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Set the authorization header
        char authorizationHeader[MAXDATASIZE];
        snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authorizationHeader);

        // Prepare the DELETE data
        char deleteData[MAXDATASIZE];
        snprintf(deleteData, MAXDATASIZE, "operationId=%s", operationId);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, deleteData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);
        curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, "DELETE"); // Set request type to DELETE

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the DELETE request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }
        else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

// DONORS AND PATIENTS APIS

void handleApplyToDispensary(int new_fd, const char* jwtToken, const char* dispensaryId, const char* phone) {

    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/donors/applyToDispensary");

    // Initialize libcurl
    CURL* curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist* headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Set the authorization header
        char authorizationHeader[MAXDATASIZE];
        snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authorizationHeader);

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "dispensaryId=%s&phone=%s", dispensaryId, phone);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }
        else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleApplyToHospital(int new_fd, const char* jwtToken, const char* hospitalId) {

    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/donors/applyToHospital");

    // Initialize libcurl
    CURL* curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist* headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Set the authorization header
        char authorizationHeader[MAXDATASIZE];
        snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authorizationHeader);

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "hospitalId=%s", hospitalId);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }
        else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

// DISPENSARY APIS

void handleAssignDateForPatientsAppointment(int new_fd, const char* jwtToken, const char* patientId, const char* time) {

    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/dispensary/assignDateForPatientsAppointment");

    // Initialize libcurl
    CURL* curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist* headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Set the authorization header
        char authorizationHeader[MAXDATASIZE];
        snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authorizationHeader);

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "patientId=%s&time=%s", patientId, time);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }
        else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleAssignDateForDonorsAppointment(int new_fd, const char* jwtToken, const char* donorId, const char* time) {

    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/dispensary/assignDateForDonorsAppointment");

    // Initialize libcurl
    CURL* curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist* headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Set the authorization header
        char authorizationHeader[MAXDATASIZE];
        snprintf(authorizationHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authorizationHeader);

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "donorId=%s&time=%s", donorId, time);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }
        else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    }
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

// USERS APIS
void handleUploadProfilePhoto(int new_fd, const char *filename) {
    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/users/uploadMyPhoto");

    // Initialize libcurl
    CURL *curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Prepare the form data
        struct curl_httppost *formpost = NULL;
        struct curl_httppost *lastptr = NULL;
        curl_formadd(&formpost, &lastptr,
                     CURLFORM_COPYNAME, "file",
                     CURLFORM_FILE, filename,
                     CURLFORM_END);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_HTTPPOST, formpost);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_formfree(formpost);
        curl_global_cleanup();
    } else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleLoginRequest(int new_fd, const char *email, const char *password) {
    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/login");

    // Initialize libcurl
    CURL *curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist *headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "email=%s&password=%s", email, password);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    } else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleSignupRequest(int new_fd, const char *fullName, const char *email, const char *password, const char *rePassword, const char *role) {
    char apiUrl[MAXDATASIZE];
    printf(fullName, email, password, rePassword, role);
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/signUp");

    // Initialize libcurl
    CURL *curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the POST parameters
        struct curl_slist *headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

        // Prepare the POST data
        char postData[MAXDATASIZE];
        snprintf(postData, MAXDATASIZE, "fullName=%s&email=%s&password=%s&rePassword=%s&role=%s",
                 fullName, email, password, rePassword, role);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postData);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the POST request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    } 
    else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

void handleGetInfoRequest(int new_fd, const char *jwtToken) {
    char apiUrl[MAXDATASIZE];
    snprintf(apiUrl, MAXDATASIZE, "http://161.35.75.184:1234/api/me");

    // Initialize libcurl
    CURL *curl;
    CURLcode res;
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    // Check if libcurl initialization is successful
    if (curl) {
        // Set the Authorization header with the JWT token
        struct curl_slist *headers = NULL;
        char authHeader[MAXDATASIZE];
        snprintf(authHeader, MAXDATASIZE, "Authorization: Bearer %s", jwtToken);
        headers = curl_slist_append(headers, authHeader);

        // Set libcurl options
        curl_easy_setopt(curl, CURLOPT_URL, apiUrl);
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

        // Create a buffer to store the response
        char responseBuffer[MAXDATASIZE];
        responseBuffer[0] = '\0';

        curl_easy_setopt(curl, CURLOPT_WRITEDATA, responseBuffer);

        // Perform the GET request
        res = curl_easy_perform(curl);

        // Check for errors during the request
        if (res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            // Print the received data (for testing purposes)
            printf("Received response from API: %s\n", responseBuffer);

            // Send the response back to the client
            if (send(new_fd, responseBuffer, strlen(responseBuffer), 0) == -1) {
                perror("send");
                exit(1);
            }
        }

        // Cleanup libcurl resources
        curl_easy_cleanup(curl);
        curl_global_cleanup();
    } else {
        fprintf(stderr, "Error initializing libcurl\n");
    }
}

int main(void) {
    int sockfd, new_fd;
    struct sockaddr_in server_addr;
    struct sockaddr_in client_addr;
    int sin_size, recvbytes;
    char buf[MAXDATASIZE];

    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = INADDR_ANY;
    bzero(&(server_addr.sin_zero), 8);

    if (bind(sockfd, (struct sockaddr *)&server_addr, sizeof(struct sockaddr)) == -1) {
        perror("bind");
        exit(1);
    }

    if (listen(sockfd, 10) == -1) {
        perror("listen");
        exit(1);
    }

    while (1) {
        sin_size = sizeof(struct sockaddr_in);

        if ((new_fd = accept(sockfd, (struct sockaddr *)&client_addr, &sin_size)) == -1) {
            perror("accept");
            continue;
        }

        printf("server: got connection from %s\n", inet_ntoa(client_addr.sin_addr));

        if ((recvbytes = recv(new_fd, buf, MAXDATASIZE, 0)) == -1) {
            perror("recv");
            exit(1);
        }

        buf[recvbytes] = '\0';
        printf("Received: %s\n", buf);

        if (strncmp(buf, "createQueue", strlen("createQueue")) == 0) {
            char jwtToken[MAXDATASIZE], name[MAXDATASIZE];
            if (sscanf(buf, "createQueue \"%[^\"]\" \"%[^\"]\"", jwtToken, name) == 2) {
            	handleCreateQueue(new_fd, jwtToken, name);
            }
            else {
		        printf("Invalid signup command format\n");
	        }
	    }
        else if (strncmp(buf, "appointOperationToAnyPatient", strlen("appointOperationByTheQueue")) == 0) {
            char jwtToken[MAXDATASIZE], doctorName[MAXDATASIZE], doctorRole[MAXDATASIZE], time[MAXDATASIZE], patientId[MAXDATASIZE], donorId[MAXDATASIZE];
            if (sscanf(buf, "appointOperationToAnyPatient \"%[^\"]\" \"%[^\"]\" \"%[^\"]\" %s %s %s", jwtToken, doctorName, doctorRole, time, patientId, donorId) == 6) {
                handleAppointOperationToAnyPatient(new_fd, jwtToken, doctorName, doctorRole, time, patientId, donorId);
            }
            else {
                printf("Invalid appointOperationToAnyPatient command format\n");
            }
        }
        else if (strncmp(buf, "appointOperationByTheQueue", strlen("appointOperationByTheQueue")) == 0) {
            char jwtToken[MAXDATASIZE], doctorName[MAXDATASIZE], doctorRole[MAXDATASIZE], time[MAXDATASIZE], donorId[MAXDATASIZE];
            if (sscanf(buf, "appointOperationByTheQueue \"%[^\"]\" \"%[^\"]\" \"%[^\"]\" %s %s", jwtToken, doctorName, doctorRole, time, donorId) == 5) {
                handleAppointOperationByTheQueue(new_fd, jwtToken, doctorName, doctorRole, time, donorId);
            }
            else {
                printf("Invalid appointOperationByTheQueue command format\n");
            }
        }
        else if (strncmp(buf, "cancelOperation", strlen("cancelOperation")) == 0) {
            char jwtToken[MAXDATASIZE], operationId[MAXDATASIZE];
            if (sscanf(buf, "cancelOperation \"%[^\"]\" %s", jwtToken, operationId) == 2) {
                handleCancelOperation(new_fd, jwtToken, operationId);
            }
            else {
                printf("Invalid CancelOperation command format\n");
            }
        }
        else if (strncmp(buf, "applyToDispensary", strlen("applyToDispensary")) == 0) {
            char jwtToken[MAXDATASIZE], dispensaryId[MAXDATASIZE], phone[MAXDATASIZE];
            if (sscanf(buf, "applyToDispensary \"%[^\"]\" %s \"%[^\"]\"", jwtToken, dispensaryId, phone) == 3) {
                handleApplyToDispensary(new_fd, jwtToken, dispensaryId, phone);
            }
            else {
                printf("Invalid applyToDispensary command format\n");
            }
        }
        else if (strncmp(buf, "applyToHospital", strlen("applyToHospital")) == 0) {
            char jwtToken[MAXDATASIZE], hospitalId[MAXDATASIZE];
            if (sscanf(buf, "applyToHospital \"%[^\"]\" %s", jwtToken, hospitalId) == 2) {
                handleApplyToHospital(new_fd, jwtToken, hospitalId);
            }
            else {
                printf("Invalid applyToHospital command format\n");
            }
        }
        else if (strncmp(buf, "assignDateForPatientsAppointment", strlen("assignDateForPatientsAppointment")) == 0) {
            char jwtToken[MAXDATASIZE], patientId[MAXDATASIZE], time[MAXDATASIZE];
            if (sscanf(buf, "assignDateForPatientsAppointment \"%[^\"]\" %s %s", jwtToken, patientId, time) == 3) {
                handleAssignDateForPatientsAppointment(new_fd, jwtToken, patientId, time);
            }
            else {
                printf("Invalid assignDateForPatientsAppointment command format\n");
            }
        }
        else if (strncmp(buf, "assignDateForDonorsAppointment", strlen("assignDateForDonorsAppointment")) == 0) {
            char jwtToken[MAXDATASIZE], donorId[MAXDATASIZE], time[MAXDATASIZE];
            if (sscanf(buf, "assignDateForDonorsAppointment \"%[^\"]\" %s %s", jwtToken, donorId, time) == 3) {
                handleAssignDateForDonorsAppointment(new_fd, jwtToken, donorId, time);
            }
            else {
                printf("Invalid assignDateForDonorsAppointment command format\n");
            }
        }
        else if (strncmp(buf, "login", 5) == 0) {
            // Extract email and password from the login command
            char email[MAXDATASIZE], password[MAXDATASIZE];
            if (sscanf(buf, "login %s %s", email, password) == 2) {
                handleLoginRequest(new_fd, email, password);
            } else {
                printf("Invalid login command format\n");
            }
        }
	// Check for signup command
        else if (strncmp(buf, "signup", 6) == 0) {
	    // Extract parameters from the signup command
	    char fullName[MAXDATASIZE], email[MAXDATASIZE], password[MAXDATASIZE], rePassword[MAXDATASIZE], role[MAXDATASIZE];

	    // Use a format specifier that allows spaces in the full name
	    if (sscanf(buf, "signup \"%[^\"]\" %s %s %s %s", fullName, email, password, rePassword, role) == 5) {
		  handleSignupRequest(new_fd, fullName, email, password, rePassword, role);
	    } else {
		  printf("Invalid signup command format\n");
	    }
	}
	// Check for getInfo command
	else if (strncmp(buf, "getMyInfo", 7) == 0) {
	    // Extract the JWT token from the getInfo command
	    char jwtToken[MAXDATASIZE];
	    if (sscanf(buf, "getMyInfo \"%[^\"]\"", jwtToken) == 1) {
		handleGetInfoRequest(new_fd, jwtToken);
	    } else {
		printf("Invalid getInfo command format\n");
	    }
	}

        close(new_fd);
    }

    return 0;
}
