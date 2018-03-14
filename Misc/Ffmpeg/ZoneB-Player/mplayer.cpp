#include "mplayer.h"
#include "PacketQueue.h"
#include <exception>
#include <SDL.h>
#include <SDL_thread.h>
#include <assert.h>
#include <pthread.h>
#include <unistd.h>


extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswscale/swscale.h>
#include <libavutil/samplefmt.h>
#include <libswresample/swresample.h>
#include <libavutil/opt.h>
}


#define SDL_AUDIO_BUFFER_SIZE 1024
#define MAX_AUDIO_FRAME_SIZE 192000
#define VTHREAD_SLEEP_TIME 25000

typedef struct CallbackData
{
	MPlayer *player;
	AVCodecContext *ctx;
	
	CallbackData(): player(NULL), ctx(NULL) {}
} CBData;



MPlayer::MPlayer(char const *input)
{
	av_register_all();
	pFormatCtx = NULL;
	videoCodecCtx = NULL;
	audioCodecCtx = NULL;
	audioQueue = NULL;
	videoQueue = NULL;
	isPlaying = 0;

	// Flags Initialization
	isVideoThreadRunning = false;
	isAudioThreadRunning = false;

	// Open an input
	try
	{
		// Open the input
		if (avformat_open_input(&pFormatCtx, input, NULL, NULL) != 0)
		{
			fprintf(stderr, "Could not open file\n");
			throw new MPInitException();
		}
		if (avformat_find_stream_info(pFormatCtx, NULL) < 0)
		{
			fprintf(stderr, "No stream found\n");
			avformat_close_input(&pFormatCtx);
			throw new MPInitException();
		}

		// Find the stream index of audio & video
		audioStreamIdx = -1;
		videoStreamIdx = -1;
		for (int i=0;i<pFormatCtx->nb_streams;i++)
		{
			if ((audioStreamIdx < 0) && (pFormatCtx->streams[i]->codec->codec_type == AVMEDIA_TYPE_AUDIO))
				audioStreamIdx = i;
			if ((videoStreamIdx < 0) && (pFormatCtx->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO))
				videoStreamIdx = i;
		}
		if ((audioStreamIdx == -1) || (videoStreamIdx == -1))
		{
			fprintf(stderr, "No stream for both video & audio\n");
			throw new MPInitException();
		}

		// Copy the audio codec contexts
		AVCodec *pCodec = NULL;
		pCodec = avcodec_find_decoder(pFormatCtx->streams[audioStreamIdx]->codec->codec_id);
		if (pCodec == NULL)
		{
			fprintf(stderr, "Unsupport audio codec\n");
			throw new MPInitException();
		}
		audioCodecCtx = avcodec_alloc_context3(pCodec);
		if (avcodec_copy_context(audioCodecCtx, pFormatCtx->streams[audioStreamIdx]->codec) != 0)
		{
			fprintf(stderr, "Couldn't copy codec context\n");
			throw new MPInitException();
		}
		avcodec_open2(audioCodecCtx, pCodec, NULL);		// Open the audio context

		// Copy the video codec
		//av_free(pCodec); 	***Note: No need to free pCodec because it points to an object in stack, not heap.
		pCodec = avcodec_find_decoder(pFormatCtx->streams[videoStreamIdx]->codec->codec_id);
		if (pCodec == NULL)
		{
			fprintf(stderr, "Unsupported video codec\n");
			throw new MPInitException();
		}
		videoCodecCtx = avcodec_alloc_context3(pCodec);
		if (avcodec_copy_context(videoCodecCtx, pFormatCtx->streams[videoStreamIdx]->codec) != 0)
		{
			fprintf(stderr, "Couldn't copy video codec context\n");
			throw new MPInitException();
		}
		avcodec_open2(videoCodecCtx, pCodec, NULL);		// Open the video context

	} 
	catch (MPInitException &e)
	{
		fprintf(stderr,"Exception thrown: %s\n", e.what());
		
		// Clean up before exit
		this->cleanup();
		exit(-1);
	}
}


MPlayer::~MPlayer()
{
	this->cleanup();
	delete audioQueue;
	delete videoQueue;
}


void MPlayer::cleanup()
{
	// Close the context
	avcodec_close(audioCodecCtx);
	avcodec_close(videoCodecCtx);
	avformat_close_input(&pFormatCtx);

	// Free the context
	avcodec_free_context(&audioCodecCtx);
	avcodec_free_context(&videoCodecCtx);
	avformat_free_context(pFormatCtx);
}


void MPlayer::readPacket(void (MPlayer::*cbFunc)(void *data), AVFrame *pFrame, void *data)
{
	int frameFinished;
	//AVFrame *pFrame = av_frame_alloc();
	AVPacket packet;
	while (av_read_frame(pFormatCtx, &packet) >= 0)
	{
		// If this packet is the video packet
		
	}
}


void MPlayer::extractFrame(int const framePeriod)
{
	// Init the RGB frame
	AVFrame *pFrameRGB = av_frame_alloc();
	if (pFrameRGB == NULL)
	{
		fprintf(stderr, "Cannot allocate the rgb rame\n");
		throw new MPExtractException();
	}
	int numBytes = avpicture_get_size(PIX_FMT_RGB24, videoCodecCtx->width, videoCodecCtx->height);
	uint8_t *buffer = (uint8_t *)av_malloc(numBytes*sizeof(uint8_t));
	

	// Setup the structure used to save RGB frame
	avpicture_fill((AVPicture *)pFrameRGB, buffer, PIX_FMT_RGB24, videoCodecCtx->width, videoCodecCtx->height);

	// Setup the swsscale context for converting format
	struct SwsContext *swsCtx = sws_getContext(videoCodecCtx->width,
		videoCodecCtx->height, videoCodecCtx->pix_fmt,
		videoCodecCtx->width, videoCodecCtx->height,
		PIX_FMT_RGB24, SWS_BILINEAR,
		NULL, NULL, NULL
		);

	// Start reading each packet
	int i= 0;
	int frameFinished;
	AVFrame *pFrame = av_frame_alloc();
	AVPacket packet;
	while (av_read_frame(pFormatCtx, &packet) >= 0)
	{
		// If this packet is a video packet
		if (packet.stream_index == videoStreamIdx)
		{
			// Decode the video frame
			avcodec_decode_video2(videoCodecCtx, pFrame, &frameFinished, &packet);

			// If we get an video frame
			if (frameFinished)
			{
				// Convert the video to RGB
				sws_scale(swsCtx, (uint8_t const * const *)pFrame->data,
						pFrame->linesize, 0, videoCodecCtx->height,
						pFrameRGB->data, pFrameRGB->linesize
					);

				// Save the frame to disk
				if (++i %framePeriod == 0)
					this->saveFrameToDisk(pFrameRGB, videoCodecCtx->width, videoCodecCtx->height, i);
			}
		}

		// Free the packet allocated by av_read_frame
		av_free_packet(&packet);
	}
	av_free(pFrame);
	

	av_free(buffer);
	av_free(pFrameRGB);
}


void MPlayer::saveFrameToDisk(AVFrame const *pFrame, int width, int height, int index) const 
{
	char fileName[32];
	sprintf(fileName, "Output/frame-%d.ppm", index);

	FILE *fileStream = fopen(fileName, "wb");
	if (fileStream == NULL)
	{
		fprintf(stderr, "Can't open file %s\n", fileName);
		return;
	}
	
	// Write the header
	fprintf(fileStream, "P6\n%d %d\n255\n", width, height);

	// Write the data
	for (int i=0;i< height;i++)
		fwrite(pFrame->data[0] + i*pFrame->linesize[0], 1, width*3, fileStream);

	fclose(fileStream);
}


void MPlayer::playVideo()
{
	// Init the two video & audio queue
	isPlaying = 1;
	audioQueue = new PacketQueue;
	videoQueue = new PacketQueue;

	// Start 3 threads
	pthread_t aThread, vThread, pThread;
	pthread_create(&pThread, NULL, &MPlayerThread::_runDepacketThread, this);
	pthread_create(&vThread, NULL, &MPlayerThread::_runVideoThread, this);
	pthread_create(&aThread, NULL, &MPlayerThread::_runAudioThread, this);

	// Processing the events
	SDL_Event event;
	while (isPlaying)
	{
		SDL_PollEvent(&event);
		switch(event.type)
		{
		case SDL_QUIT:
			this->stopPlaying();
			SDL_Quit();
		default:
			break;
		}

		usleep(100000);
		if (!isVideoThreadRunning && !isAudioThreadRunning)
			this->stopPlaying();
	}

	// Wait the three threads to stop completely
	pthread_join(pThread, NULL);
	pthread_join(vThread, NULL);
	pthread_join(aThread, NULL);

	delete audioQueue; audioQueue= NULL;
	delete videoQueue; videoQueue= NULL;
}


void MPlayer::stopPlaying()
{
	fprintf(stderr, "Stop the player now\n");
	isPlaying = 0;
	audioQueue->stopPoppingThread();
	videoQueue->stopPoppingThread();
	SDL_Quit();
}


void *MPlayer::depacketThread(void *data)
{
	// Reading the packet
	AVPacket packet;
	SDL_Event event;
	while (av_read_frame(pFormatCtx, &packet) >= 0)
	{
		if (packet.stream_index == videoStreamIdx)
			videoQueue->push(&packet);
		else if (packet.stream_index == audioStreamIdx)
			audioQueue->push(&packet);
		else
			av_free_packet(&packet);		
	}

	fprintf(stderr,"Depacketing completed\n");
}


void *MPlayer::videoThread(void *data)
{
	isVideoThreadRunning = true;

	// Init the SDL Display window
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER))
	{
		fprintf(stderr, "Could not initialize the SDL - %s\n", SDL_GetError());
		exit(1);
	}

	// Creating a Display
	SDL_Window *screen;
	screen = SDL_CreateWindow("FFmpeg - Tutorial", 
		SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
		videoCodecCtx->width, videoCodecCtx->height, 0
		);
	if (!screen)
	{
		fprintf(stderr, "SDL: Could not set the video mode for SDL screen - exiting\n");
		exit(-1);
	}

	// Create SDL Renderer
	SDL_Renderer *renderer = SDL_CreateRenderer(screen, -1, 0);
	if (!renderer)
	{
		fprintf(stderr, "SDL: Could not creat renderer - exiting\n");
		exit(-1);
	}

	// Allocate place to put our YUV image on the screen
	SDL_Texture *texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_YV12,
		SDL_TEXTUREACCESS_STREAMING,
		videoCodecCtx->width, videoCodecCtx->height
		);
	if (!texture)
	{
		fprintf(stderr, "SDL: could not create texture - exiting\n");
		exit(-1);
	}

	// Setup YV12 pixel array 
	size_t yPlaneSz = videoCodecCtx->width * videoCodecCtx->height;
	size_t uvPlaneSz = videoCodecCtx->width * videoCodecCtx->height / 4;
	Uint8 *yPlane = (Uint8 *)malloc(yPlaneSz);
	Uint8 *uPlane = (Uint8 *)malloc(uvPlaneSz);
	Uint8 *vPlane = (Uint8 *)malloc(uvPlaneSz);
	int uvPitch = videoCodecCtx->width / 2;

	// Initalize the SWS conext for software scaling
	struct SwsContext *swsCtx = sws_getContext(videoCodecCtx->width,
			videoCodecCtx->height,
			videoCodecCtx->pix_fmt,
			videoCodecCtx->width,
			videoCodecCtx->height,
			PIX_FMT_YUV420P,
			SWS_BILINEAR,
			NULL, NULL, NULL
		);


	// Start displaying the video
	AVPacket vPkt;
	int frameFinished;
	AVFrame *pFrame = av_frame_alloc();
	while (isPlaying)
	{
		// Dequeue a video packdet
		if (this->videoQueue->pop(&vPkt, 1) < 0)
		{
			fprintf(stderr, "Some error occurs when dequeuing the video packet\n");
			exit(-1);
		}

		// Start displaying the frames
		// Decode the packet into the pFrame
		avcodec_decode_video2(videoCodecCtx, pFrame, &frameFinished, &vPkt);

		// If we get an video frame
		if (frameFinished)
		{
			AVPicture pict;
			pict.data[0] = yPlane;
			pict.data[1] = uPlane;
			pict.data[2] = vPlane;

			pict.linesize[0] = videoCodecCtx->width;
			pict.linesize[1] = uvPitch;
			pict.linesize[2] = uvPitch;

			// Convert the frame to target pictures
			sws_scale(swsCtx, (uint8_t const * const *)pFrame->data, 
				pFrame->linesize, 0, videoCodecCtx->height,
				pict.data, pict.linesize
				);

			// Unlock and display the SDL overlay
			SDL_UpdateYUVTexture(texture, NULL, yPlane, videoCodecCtx->width, uPlane, uvPitch, vPlane, uvPitch);
			SDL_RenderClear(renderer);
			SDL_RenderCopy(renderer, texture, NULL, NULL);
			SDL_RenderPresent(renderer);

			// Sleep sleep sleep
			usleep(VTHREAD_SLEEP_TIME);
		}

		// Dereference the pFrame
		av_frame_unref(pFrame);
		av_free_packet(&vPkt);	// Free the packet allocatdded by av_read_frame
	}

	// Log
	fprintf(stderr, "\tThe video thread has just finished\n");

	// Free the memory
	av_free(pFrame);
	SDL_DestroyTexture(texture);
	SDL_DestroyRenderer(renderer);
	SDL_DestroyWindow(screen);

	isVideoThreadRunning = false;
}


void *MPlayer::audioThread(void *data)
{
	isAudioThreadRunning = true;

	// Init the SDL audio
	if (SDL_Init(SDL_INIT_AUDIO))
	{
		fprintf(stderr, "Cannot init sdl audio: %s\n", SDL_GetError());
		exit(-1);
	}

	// Setup the SDL Audio
	for (int i=0 ;i < SDL_GetNumAudioDevices(0); i++)
		fprintf(stderr,"Audio device %d: %s\n", i, SDL_GetAudioDeviceName(i,0));

	SDL_AudioSpec targetSpec;
	SDL_AudioSpec obtainedSpec;
	SDL_AudioDeviceID audioDev;
	targetSpec.freq = audioCodecCtx->sample_rate;
	targetSpec.format = AUDIO_F32LSB;
	targetSpec.channels = audioCodecCtx->channels;
	targetSpec.silence = 0;
	targetSpec.samples = SDL_AUDIO_BUFFER_SIZE*2;	// The audio speed will be increased if the buffer < cb buffer size
	targetSpec.callback = &MPlayer::audio_callback;
	targetSpec.userdata = this;
	
	audioDev = SDL_OpenAudioDevice(NULL, 0, &targetSpec, &obtainedSpec, SDL_AUDIO_ALLOW_FORMAT_CHANGE);
	if ( audioDev <= 0)
	{
		fprintf(stderr, "SDL_OpenAudioDevice: %s\n", SDL_GetError());
		return NULL;
	}

	// Start playing the device
	SDL_PauseAudioDevice(audioDev, 0);	


	// Start do something to the end
	while (isPlaying)
	{
		usleep(100000);
	}

	// Log
	fprintf(stderr, "\tThe audio thread has just finished\n");

	// Close the audio device
	SDL_CloseAudioDevice(audioDev);

	isAudioThreadRunning = false;
}


void MPlayer::audio_callback(void *userdata, Uint8 *stream, int len)
{
	MPlayer *player = static_cast<MPlayer *>(userdata);
	
	static uint8_t audioBuff[(MAX_AUDIO_FRAME_SIZE * 3) / 2];
	static unsigned int audioBuffSize = 0;
	static unsigned int audioBuffIndex = 0;

	while (len > 0)
	{
		int audioSize = 0;
		if (audioBuffSize >= audioBuffIndex)
		{
			// All data has been sent out, get more
			audioSize = player->audio_decode_frame(audioBuff, sizeof(audioBuff));
			if (audioSize < 0)
			{
				// Error, output silence
				audioBuffSize = 1024;
				memset(audioBuff, 0, audioBuffSize);
			}
			else
				audioBuffSize = audioSize;
			audioBuffIndex = 0;

			// Debug codde
			//static FILE *outStream = fopen("audioOutput-cb.pcm", "wb");
			//fwrite(audioBuff, audioSize, 1, outStream);
		}

		int copiedLen = audioBuffSize - audioBuffIndex;
		if (copiedLen > len)
			copiedLen = len;
		memcpy(stream, (uint8_t *)audioBuff + audioBuffIndex, copiedLen);
		len -= copiedLen;
		stream += copiedLen;
		audioBuffIndex += copiedLen;
	}
}


int MPlayer::audio_decode_frame(unsigned char *audioBuf, int bufSize)
{
	static AVPacket pkt;
	static uint8_t *audioPktData = NULL;
	static int audioPktSize = 0;
	static AVFrame frame;

	while(true)
	{
		// If isStop, stop it
		if (!isPlaying)
			return -1;

		// If the audio packet is used up, request a new one
		// Stop with queue
		if (audioPktSize <= 0)
		{
			av_free_packet(&pkt);
			memset(&pkt, 0, sizeof(AVPacket));
			if (this->audioQueue->pop(&pkt, 1) < 0)
				return -1;
			audioPktSize = pkt.size;
			audioPktData = pkt.data;
		}

		// Start decoding now
		int receivedFrames = 0;
		int len = avcodec_decode_audio4(this->audioCodecCtx, &frame, &receivedFrames, &pkt);
		if (len < 0)
		{
			// The frame is error, skip it
			audioPktSize = 0;
			continue;
		}
		
		// Packet decode successfully, 
		audioPktSize -= len;
		int dataSize = 0;
		if (receivedFrames)
		{
			dataSize = av_samples_get_buffer_size(NULL, audioCodecCtx->channels,
				frame.nb_samples, audioCodecCtx->sample_fmt, 1
				);
			assert(dataSize <= bufSize);
			if (dataSize <= 0)
				continue;

			// Copy the audio buffer from two planes to the buffer
			int sampleSize = dataSize/(frame.nb_samples*2);
			for (int i=0; i < frame.nb_samples; i++)
			{
				memcpy(audioBuf + 2*i*sampleSize, frame.data[0] + i*sampleSize, sampleSize);
				memcpy(audioBuf + (2*i+1)*sampleSize, frame.data[1] + i*sampleSize, sampleSize);
			}
			//this->saveAudioToDisk(&frame);
			return dataSize;
		}
	}

	return 0;
}


void MPlayer::saveAudioToDisk(AVFrame const * const aFrame)
{
	// Convert the float multiplanar to S16
	int rt = -1;
	static struct SwrContext *swrCtx = NULL;
	if (swrCtx == NULL)
	{
		swrCtx = swr_alloc();
		av_opt_set_int(swrCtx, "in_channel_layout", 2, 0);
		av_opt_set_int(swrCtx, "in_sample_rate", audioCodecCtx->sample_rate, 0);
		av_opt_set_int(swrCtx, "in_sample_fmt", audioCodecCtx->sample_fmt, 0);

		av_opt_set_int(swrCtx, "out_channel_layout", 2, 0);
		av_opt_set_int(swrCtx, "out_sample_rate", audioCodecCtx->sample_rate, 0);
		av_opt_set_int(swrCtx, "out_sample_fmt", AV_SAMPLE_FMT_S32, 0);

		// Initialize the resampling context
		if ((rt = swr_init(swrCtx)) < 0)
		{
			fprintf(stderr, "Can't init the converting context for audio\n");
			return;
		}
	}

	// Resample the frame
	int dst_sampleCount = aFrame->nb_samples;
	uint8_t **buf = NULL;
	int dst_linesize;
	av_samples_alloc_array_and_samples(&buf, &dst_linesize, 2, dst_sampleCount, AV_SAMPLE_FMT_S32, 1);
	rt = swr_convert(swrCtx, buf, dst_sampleCount, const_cast<const uint8_t **>(aFrame->data), aFrame->nb_samples);

	// Write to file
	int bufSize = av_samples_get_buffer_size(NULL, audioCodecCtx->channels, aFrame->nb_samples, audioCodecCtx->sample_fmt, 1);
	
	// Resample file
	static FILE *resa_stream = fopen("audioOutput-resample.pcm", "wb");
	fwrite(buf[0], bufSize/2, 1, resa_stream);

	// Original file
	static FILE *audioStream = fopen("audioOutput.pcm", "wb");
	int sampleSize = bufSize/(aFrame->nb_samples*2);
	for (int i=0; i < aFrame->nb_samples;i++)
	{
		fwrite(aFrame->data[0]+i*sampleSize, sampleSize, 1, audioStream);
		fwrite(aFrame->data[1] + i*sampleSize, sampleSize, 1, audioStream);
	}

	av_freep(&buf[0]);
	av_freep(&buf);
}


void MPlayer::printAudioDeviceInfo()
{
	int index = 0;
	char const *dName;
	fprintf(stderr, "SDL Driver list:\n");
	while (dName = SDL_GetAudioDeviceName(index, 0))
	{
		fprintf(stderr, "Device %d: %s\n", index, dName);
		index++;
	}


	// Print the audio drivers info
	for (int i=0;i<SDL_GetNumAudioDrivers();i++)
	{
		printf("%s\n", SDL_GetAudioDriver(i));	
	}
	
}


void *MPlayerThread::_runVideoThread(void *ptr)
{
	MPlayer *player = static_cast<MPlayer *>(ptr);
	player->videoThread(NULL);
}


void *MPlayerThread::_runAudioThread(void *ptr)
{
	MPlayer *player = static_cast<MPlayer *>(ptr);
	player->audioThread(NULL);
}


void *MPlayerThread::_runDepacketThread(void *ptr)
{
	MPlayer *player = static_cast<MPlayer *>(ptr);
	player->depacketThread(NULL);
}
