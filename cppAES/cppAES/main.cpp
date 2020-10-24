#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>
#include <string_view>
#include "AESEncryptor.h"

int main()
{
	AESEncryptor<16U> aes{
		"Critical Annihilation", "Thats my Kung Fu"
	};
}
