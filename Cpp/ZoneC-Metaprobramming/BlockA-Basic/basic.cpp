#include <stdio.h>

void my_print(char const *format) {
	printf("%s", format);
}

template <typename T, class... TArgs>
void my_print(char const *format, T value, TArgs... FArgs) {
	for (; *format != '\0'; ++format) {
		if (*format == '%') {
			printf("%d", value);
			my_print(format+1, FArgs...);
			return;
		}
		else
			printf("%c", *format);
	}
}


int main(int argc, char *argv[]) {
	my_print("The values are: % and % and %\n", 10, 20 ,30);
	return 0;
}
