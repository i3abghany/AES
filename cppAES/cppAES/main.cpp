#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>
#include <string_view>
#include "AES.h"

int main()
{
	AES<16U> aes{
		"This Cake is a Lie", "Thats my Kung Fu"
	};
	std::string enc = aes.Encrypt();


	return 0;
}
