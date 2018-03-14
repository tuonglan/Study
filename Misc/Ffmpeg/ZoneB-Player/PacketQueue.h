struct AVPacketList;
struct AVPacket;
struct SDL_mutex;
struct SDL_cond;


class PacketQueue
{
public:
	// Constructor & Destructor
	PacketQueue();
	virtual ~PacketQueue();
	
	virtual int push(AVPacket const *pkt);
	virtual int pop(AVPacket *pkt, int block); 
	virtual void stopPoppingThread();
	virtual bool isEmpty() const;
	virtual int getCount() const {return pktCount;}

protected:
	virtual void empty();

private:
	AVPacketList *firstPkt;
	AVPacketList *lastPkt;
	int pktCount;
	int pktSize;
	int isStopped;

	SDL_mutex *mutex;
	SDL_cond *cond;
};
