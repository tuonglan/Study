#include <exception>

// Forward declaration
struct AVFormatContext;
struct AVCodecContext;
struct AVFrame;
class PacketQueue;
typedef unsigned char Uint8;


class MPlayerThread
{
public:
	static void *_runAudioThread(void *);
	static void *_runVideoThread(void *);
	static void *_runDepacketThread(void *);
};


class MPlayer
{
public:
	// Constructors & Destructor
	MPlayer(char const *input);
	virtual ~MPlayer();

	// Public members
	virtual void extractFrame(int const framePeriod);
	virtual void playVideo();
protected:
	virtual void cleanup();
	virtual void stopPlaying();
	virtual void readPacket(void (MPlayer::*)(void *), AVFrame *pFrame, void *data);
	virtual void saveFrameToDisk(AVFrame const *pFrame, int width, int height, int index) const;
	virtual void saveAudioToDisk(AVFrame const * const aFrame);

	static void audio_callback(void *userdata, Uint8 *stream, int len);
	int audio_decode_frame(unsigned char *audioBuf, int bufSize);

	void *audioThread(void *data);
	void *videoThread(void *data);
	void *depacketThread(void *data);

	// INformation
	virtual void printAudioDeviceInfo();
private:
	AVFormatContext *pFormatCtx;
	AVCodecContext *videoCodecCtx;
	AVCodecContext *audioCodecCtx;
	PacketQueue *audioQueue;
	PacketQueue *videoQueue;

	int audioStreamIdx;
	int videoStreamIdx;
	int isPlaying;

	// Friendly function declaration
	friend void *MPlayerThread::_runVideoThread(void *);
	friend void *MPlayerThread::_runAudioThread(void *);
	friend void *MPlayerThread::_runDepacketThread(void *);

	// Flags
	bool isVideoThreadRunning;
	bool isAudioThreadRunning;
};


// --------------------- Exception ----------------------------
class MPInitException : public std::exception
{
public: char const *what() const throw() { return "Error when initalizing the input stream";}	
};

class MPExtractException : public std::exception
{
public: char const *what() const throw() { return "Error when extracting the image from video";}
};



