#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>
#include <string_view>
#include "AES.h"


int main()
{
	std::string plainText = "Critical Annihilation";
	AES<16U> aes {
		plainText, "Kung Fu Fighting"
	};

	std::string encryptedText = aes.Encrypt();
	AES<16U> Daes {
		encryptedText, "Kung Fu Fighting"
	};
	auto decryptedText = Daes.Decrypt();
	assert(decryptedText == plainText);
	return 0;
}
