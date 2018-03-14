#include "PacketQueue.h"
#include <SDL.h>
#include <SDL_thread.h>

extern "C"
{
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
}


PacketQueue::PacketQueue()
	: firstPkt(NULL), lastPkt(NULL), pktCount(0), pktSize(0), isStopped(0)
{
	mutex = SDL_CreateMutex();
	cond = SDL_CreateCond();
}


PacketQueue::~PacketQueue()
{
	// Clear the mutex and cond
	// NOTE: execute these without any concern for any existing threads
	this->stopPoppingThread();
	SDL_DestroyMutex(mutex);
	SDL_DestroyCond(cond);

	// Free all the remaining packet
	while (firstPkt != NULL)
	{
		lastPkt = firstPkt->next;
		av_free(firstPkt);
		firstPkt = lastPkt;
	}
}


bool PacketQueue::isEmpty() const
{
	if (pktCount == 0)
		return true;
	else
		return false;
}


int PacketQueue::push(AVPacket const *pkt)
{
	// It's a trick to check if the pkg is allocated or not
	if (av_dup_packet(const_cast<AVPacket *>(pkt)) < 0)
	{
		return -1;
	}

	// Create a new packetlist for this paket
	AVPacketList *pktList = (AVPacketList *)av_malloc(sizeof(AVPacketList));
	if (!pktList)
	{
		fprintf(stderr,"Failed to allocate new memory for the new packet\n");
		return -1;
	}
	pktList->pkt = *pkt;
	pktList->next = NULL;

	// Start inserting
	SDL_LockMutex(mutex);
	if (firstPkt)
	{
		lastPkt->next = pktList;
		lastPkt = pktList;
	}
	else
	{
		firstPkt = pktList;
		lastPkt = pktList;
	}
	pktCount++;
	pktSize += pktList->pkt.size;
	SDL_CondSignal(cond);
	SDL_UnlockMutex(mutex);
}


int PacketQueue::pop(AVPacket *pkt, int block)
{
	int rt = -1;

	// ** Implement the quit function right here

	// Try to lock the mutext
	SDL_LockMutex(mutex);

	while(true & !isStopped)
	{
		AVPacketList *pktList = this->firstPkt;
		if (pktList)
		{
			// Cut the head of the queue
			firstPkt = firstPkt->next;
			if (!firstPkt)
				lastPkt = NULL;
			pktCount--;
			pktSize -= pktList->pkt.size;

			*pkt = pktList->pkt;
			av_free(pktList);
			rt = 0;
			break;
		}
		else if (block)
		{
			SDL_CondWait(cond, mutex);
		}
		else
			break;
	}

	SDL_UnlockMutex(mutex);
	return rt;
}


void PacketQueue::empty()
{
	AVPacketList *pktList;
	while (firstPkt != NULL)
	{
		pktList = firstPkt;
		av_free(pktList);
		firstPkt = firstPkt->next;
	}

	firstPkt = NULL;
	lastPkt = NULL;
	pktCount = 0;
	pktSize = 0;
}


void PacketQueue::stopPoppingThread()
{
	isStopped = 1;
	this->empty();
	SDL_CondSignal(cond);
}

