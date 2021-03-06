#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#include <SDL_thread.h>

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswscale/swscale.h>
}

int save_frame_to_disk(AVFrame const *pFrame, int width, int height, int index);


int main(int argc, char *argv[])
{
	av_register_all();

	// Open video file
	AVFormatContext *pFormatCtx = NULL;
	if (avformat_open_input(&pFormatCtx, argv[1], NULL, NULL) != 0)
	{
		fprintf(stderr, "Could not open file: %s\n", argv[1]);
		return -1;
	}
	if (avformat_find_stream_info(pFormatCtx, NULL) < 0)
	{
		fprintf(stderr, "Couldn't find stream information\n");
		return -1;
	}

	// Find the first video stream
	AVCodecContext *pCodecCtxOrig = NULL;
	AVCodecContext *pCodecCtx = NULL;
	int videoStream = -1;
	for (int i=0;i<pFormatCtx->nb_streams;i++)
	{
		if (pFormatCtx->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO)
		{
			videoStream = i;
			break;
		}
	}
	if (videoStream == -1)
	{
		fprintf(stderr, "Could not find any video stream\n");
		return -1;
	}

	// Get a pointer to the codec context for the video stream
	pCodecCtxOrig = pFormatCtx->streams[videoStream]->codec;

	// Find the decoder for the video stream
	AVCodec *pCodec = NULL;
	pCodec = avcodec_find_decoder(pCodecCtxOrig->codec_id);
	if (pCodec == NULL)
	{
		fprintf(stderr, "Unsupported codec!\n");
		return -1;
	}

	// Copy context
	pCodecCtx = avcodec_alloc_context3(pCodec);
	if (avcodec_copy_context(pCodecCtx, pCodecCtxOrig) != 0)
	{
		fprintf(stderr, "Couln't copy codec context\n");
		return -1;
	}

	
	// Storing the data
	//AVFrame *pFrame = av_frame_alloc();		// Allocate the video frame
	AVFrame *pFrameRGB = av_frame_alloc();	// Allocate an AVFrame structure
	if (pFrameRGB == NULL)
	{
		fprintf(stderr, "Cannot allocate the rgb frame\n");
		return -1;
	}
	uint8_t *buffer = NULL;
	int numBytes;
	numBytes = avpicture_get_size(PIX_FMT_RGB24, pCodecCtx->width, pCodecCtx->height);
	buffer = (uint8_t *)av_malloc(numBytes*sizeof(uint8_t));

	// Setup the structure pointed to by the AVPicture with the buffer & image format
	avpicture_fill((AVPicture *)pFrameRGB, buffer, PIX_FMT_RGB24, pCodecCtx->width, pCodecCtx->height);

	
	// Init the SDL Display window
	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER))
	{
		fprintf(stderr, "Could not initialize SDL - %s\n", SDL_GetError());
		exit(1);
	}

	// Creating a Display
	SDL_Surface *screen;
	screen = SDL_SetVideoMode(pCodecCtx->width, pCodecCtx->height, 0, 0);
	if (!screen)
	{
		fprintf(stderr, "SDL: Could not set video mode - exiting \n");
		exit(1);
	}
	
	// Create an overlay
	SDL_Overlay *bmp = SDL_CreateYUVOverlay(pCodecCtx->width, pCodecCtx->height, SDL_YV12_OVERLAY, screen);
	SDL_Rect rect;
	rect.x = 0; rect.y = 0;
	rect.w = pCodecCtx->width;
	rect.h = pCodecCtx->height;

	// Reading the data
	struct SwsContext *swsCtx = NULL;
	AVPacket packet;

	// Initialize the SWS context for software scaling
	swsCtx = sws_getContext(pCodecCtx->width,
		pCodecCtx->height,
		pCodecCtx->pix_fmt,
		pCodecCtx->width,
		pCodecCtx->height,
		PIX_FMT_YUV420P,
		SWS_BILINEAR,
		NULL, NULL, NULL
		);

	// Open the new copied codec context
	avcodec_open2(pCodecCtx, pCodec, NULL);


	// Start reading each packet
	int i=0;
	int frameFinished;
	AVFrame *pFrame = av_frame_alloc();
	SDL_Event event;
	while (av_read_frame(pFormatCtx, &packet) >= 0)
	{
		// IF this packet is the video packet
		if (packet.stream_index == videoStream)
		{
			// Decode the video frame
			avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, &packet);

			// If we get an video frame
			if (frameFinished)
			{
				SDL_LockYUVOverlay(bmp);
				AVPicture pict;
				pict.data[0] = bmp->pixels[0];
				pict.data[1] = bmp->pixels[2];
				pict.data[2] = bmp->pixels[1];

				pict.linesize[0] = bmp->pitches[0];
				pict.linesize[1] = bmp->pitches[2];
				pict.linesize[2] = bmp->pitches[1];

				// Convert from YUV (maybe) to target
				sws_scale(swsCtx, (uint8_t const * const *)pFrame->data,
					pFrame->linesize, 0, pCodecCtx->height,
					pict.data, pict.linesize
					);

				// SDL_UnlockYUVOverlay
				SDL_UnlockYUVOverlay(bmp);

				// Display it to the screen
				SDL_DisplayYUVOverlay(bmp, &rect);
			}
			
			//Dereference the pFramej
			av_frame_unref(pFrame);
		}

		// Free the packet allocated by av_read_frame
		av_free_packet(&packet);
		SDL_PollEvent(&event);
		switch(event.type)
		{
		case SDL_QUIT:
			SDL_Quit();
			exit(0);
			break;
		default:
			break;
		}
	}

	
	// Clean up
	av_free(buffer);
	av_free(pFrameRGB);
	av_free(pFrame);

	// Close the codecs
	avcodec_close(pCodecCtx);
	avcodec_close(pCodecCtxOrig);
	avformat_close_input(&pFormatCtx);
	
	printf("Hello World\n");
}



int save_frame_to_disk(AVFrame const *pFrame, int width, int height, int index)
{
	FILE *fileStream;
	char fileName[32];

	sprintf(fileName, "Output/frame%d.ppm", index);
	fileStream = fopen(fileName, "wb");
	if (fileStream == NULL)
	{
		fprintf(stderr, "Can't not open file %s\n", fileName);
		return -1;
	}

	// Write the header file
	fprintf(fileStream, "P6\n%d %d\n255\n", width, height);

	// Write the data
	for (int i=0;i<height;i++)
		fwrite(pFrame->data[0] + i*pFrame->linesize[0], 1, width*3, fileStream);

	fclose(fileStream);

	return 0;
}
