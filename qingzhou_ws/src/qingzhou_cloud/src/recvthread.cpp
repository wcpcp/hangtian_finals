

#include<iostream>
#include"recvthread.h"
using namespace std;


recvthread::recvthread(){
}

recvthread::~recvthread()
{
}

int app::set_socket_nonblock(int sockfd)
{
     int block_flag = fcntl(sockfd, F_GETFL, 0);
     if(block_flag < 0){
       printf("qingzhou_cloud-->get socket fd flag error:%s\n", strerror(errno));
       return -1;
     }
     else{
       if(fcntl(sockfd, F_SETFL, block_flag | O_NONBLOCK) < 0){
           printf("qingzhou_cloud-->set socket fd non block error:%s\n", strerror(errno));
           return -1;
       }
     }
     return 0;
}

int app::net_tcp_init()
{
        int ret = 0;
        clientIsConnect = 0;
        struct sockaddr_in server_addr;
        int err;
        int sockflag = 1;
        struct linger LINgerr;
        LINgerr.l_onoff = 0;
        while(1){
        clientfd = socket(AF_INET, SOCK_STREAM, 0);
        if (clientfd < 0) {
                printf("qingzhou_cloud-->client : create socket error\n");
                return -1;
        }
        if(setsockopt(clientfd,SOL_SOCKET,SO_REUSEADDR,&sockflag,sizeof(int)) < 0){
            printf("qingzhou_cloud-->setsockopt error\n");
        }
        // connect
        memset(&server_addr,0,sizeof(server_addr));
        server_addr.sin_family = AF_INET;
        server_addr.sin_port = htons(mfcCloudPortNum);
        server_addr.sin_addr.s_addr = inet_addr(mfcCloudIP.c_str());//"127.0.0.1" ipTarget.c_str()  mfcCloudIP.c_str()

        while(1){
            sleep(1);
            err = connect(clientfd,(struct sockaddr *)&server_addr,sizeof(struct sockaddr));
            if(err == 0) {
                clientIsConnect = 1;
                disconnectFlag = 2;
                printf("qingzhou_cloud-->client : connect to server,clientfd = %d\n",clientfd);
                recvflag = 0;
                heartFlag = 0;
                continue;
            }
            if  (disconnectFlag == 1){
                clientIsConnect = 0;
                close(clientfd);
                printf("qingzhou_cloud-->disconnect\n");
                break;
            }
            if  (errno == EISCONN){
                clientIsConnect = 1;
                sleep(2);
                continue;
            }
            if(err < 0){
                if (errno == EINPROGRESS){
                }
            }
        }
        }
}

int app::recvn(void *buf,const int recvLen){
    int recvlength = recvLen;
    int readlen = 0;
    char *ptr = (char*)buf;
    while(recvlength > 0){
        int ret = recv(clientfd, ptr, recvlength, 0);
        if(ret == 0){
            clientIsConnect = 0;//I think socket is disconnect
            disconnectFlag = 1;
            close(clientfd);
            readlen = -1;
            break;
        }
        if(ret < 0){
            if(errno == EAGAIN){
                continue;
            }
        }
        recvlength -= ret;
        readlen += ret;
        ptr += ret;
    }
    return readlen;
}

void app::RecvThreadFromMfc(){
    char recvbuf[9] = {0,};
    char recvInfobuf[10256] = {0,};
    recv_frame_t* pheader = (recv_frame_t*)recvbuf;
    unsigned int frame_len = 0;
    while(1){
        usleep(50000);
        if(clientIsConnect == 1){
            volatile int size = 0;
            volatile int intoret = 0;
            volatile int ret = 0;
            struct timeval tv;
            fd_set readfds;
            FD_ZERO(&readfds);
            FD_SET(clientfd, &readfds);
            tv.tv_sec = 0;
            tv.tv_usec = 50000;
            ret = select(clientfd+1, &readfds, NULL, NULL, &tv);
            if(ret == 0){
                continue;
            }
            else if(ret < 0 && errno != EINTR) {
                clientIsConnect = 0;//I think socket is disconnect
                close(clientfd);
                continue;
            }else if((ret > 0)&&(errno != EINTR)){
                if(FD_ISSET(clientfd,&readfds)){
                    size = recvn(recvbuf, 9);
                    if(size < 0){
                        printf("qingzhou_cloud recv failed....\n");
                        continue;
                    }
                    if(size > 0){
                        heartdisconnectCommand = 0;
                        if(bdebug == 1){
                            printf("recv size is %d\n",size);
                            for(int i = 0;i < size;i++){
                                printf(" %02x",recvbuf[i]);
                            }
                            printf("\n");
                        }
                        if((recvbuf[0] != 0x02)||(recvbuf[1] != 0x20)||(recvbuf[2] != 0x02)||(recvbuf[3] != 0x20)){
                            printf("qingzhou_cloud recv header error....\n");
                            continue;
                        }
                        frame_len = (recvbuf[4] & 0xff) + ((recvbuf[5] & 0xff)<<8) + ((recvbuf[6] & 0xff)<<16) + ((recvbuf[7] & 0xff)<<24);

                        intoret = recvn(recvInfobuf, frame_len-1);
                        if(bdebug == 1){
                            printf("recv len is %d,command is %02x,para[0] is %d\n",pheader->len,pheader->command,recvInfobuf[0]);
                        }
                        if(intoret  < 0){
                            printf("qingzhou_cloud recv Info failed....\n");
                            continue;
                        }else {
                            heartFlag = 0;
                        //    recvflag = 0;
                            if(bdebug == 1){
                                printf("recv info size is %d\n",intoret);
                                for(int i = 0;i < intoret;i++){
                                    printf(" %02x",recvInfobuf[i]);
                                }
                                printf("\n");
                            }
                        }
                        switch(pheader->command){
                        case 0x10:{//重新开始
                            // system("rosnode kill -a");
                            // break;
                            // printf("Recv restart car\n");
                            
                        }
                        case 0x20:{//stop
                            recvflag = 2;
                            qingzhou_cloud::startstopCommand ssCommand;
                            ssCommand.startstopcommand = 0x02;
                            pub_start_stop_command.publish(ssCommand);
                            heartFlag = 0;
                            //printf("Recv stop navigation command %d\n",recvInfobuf[0]);
                            printf("Recv stop navigation command %d\n",ssCommand.startstopcommand);
                            break;
                        }
                        case 0x30:{//first stop point 出发点
                            // float x = 0,y = 0;
                            // memcpy(&x,recvInfobuf,4);
                            // memcpy(&y,recvInfobuf+4,4);
                            // printf("Recv first stop point x = %.2f,y =  %.2f\n",x,y);
                            // recvflag = 7;
                            // heartFlag = 0;
                            // qingzhou_cloud::stoppoint spoint;
                            // spoint.X = x;
                            // spoint.Y = y;
                            // pub_stop_point.publish(spoint);
                            //  break;
                            // ros::param::set("task",0);
                            //  break;
                            // system("cd open_ros_node");
                            // system("bash /home/learningx/open_ros_node/cmd_vel_ctrl.sh");
                            printf("---------------------------start------------------------\n");
                            break;
                        }
                        case 0x40:{//second stop point 卸货区
                            // ros::param::set("/task",1);
                            printf("---------------------------task = 1------------------------\n");
                            break;
                        }
                        case 0x50:{//third stop command卸货区到出发点
                            // ros::param::set("/task",2);
                            printf("---------------------------task = 2------------------------\n");
                            break;
                        }
                        case 0x77:{//heart recv
                            heartFlag = 0;
                            break;
                        }
                        default:break;
                        }
                    }
                }
            }
        }
    }
}

void app::detectConnectThread(){
    int ret = net_tcp_init();
    if(ret < 0){
        printf("qingzhou_cloud detectConnectThread-->client : connect error\n");
    }else if(ret == 0){
        printf("qingzhou_cloud detectConnectThread-->client : connect success\n");
    }
}