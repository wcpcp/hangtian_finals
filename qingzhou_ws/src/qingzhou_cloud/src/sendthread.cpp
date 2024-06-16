

#include<iostream>
#include "sendthread.h"

sendthread::sendthread(){
}

sendthread::~sendthread()
{
}
int app::sendHeartThread(){
    // while(1){
    //     usleep(100000);
    //     heartFlag++;
    //     if(heartFlag >20){
    //         heartFlag = 0;
    //         heartdisconnectCommand++;
    //         if(heartdisconnectCommand == 2 && recvflag != 0){
    //             heartdisconnectCommand = 0;
    //             disconnectFlag = 1;
    //             clientIsConnect = 0;
    //         }
    //         char send_buf[126] = {0,};
    //         send_frame_t* send_frame = (send_frame_t*)send_buf;
    //         send_frame->head[0] = 0x02;
    //         send_frame->head[1] = 0x20;
    //         send_frame->head[2] = 0x02;
    //         send_frame->head[3] = 0x20;
    //         send_frame->len = 0x07;
    //         send_frame->command = 0x71;
    //         send_buf[9] = 1;
    //         send_buf[10] = 2;
    //         send_buf[11] = 0x03;
    //         send_buf[12] = 0x30;
    //         send_buf[13] = 0x03;
    //         send_buf[14] = 0x30;
    //         int ret = send(clientfd, send_buf, send_frame->len + 8, 0);
    //         if(ret < 0)
	// 	printf("qingzhou_cloud-->send heart error %d\n",errno);
    //     }
    // }
}
