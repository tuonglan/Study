#include "mplayer.h"
#include "PacketQueue.h"
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[])
{
	MPlayer *imageExtracter = new MPlayer(argv[1]);
	
	// Tutorial 1
	//imageExtracter->extractFrame(25);

	// Tutorial 2
	imageExtracter->playVideo();

	delete imageExtracter;
	printf("Hello world\n");
	return 0;
}
