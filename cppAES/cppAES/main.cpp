#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>
#include <string_view>
#include "AES.h"

int main()
{
	std::string plainText = "Critical Annihilation";
	std::string key = "Kung Fu Fighting";

	AES<16U> aes{
		plainText, key
	};

	std::string encryptedText = aes.Encrypt();

	aes.load(encryptedText, key);

	auto decryptedText = aes.Decrypt();

	assert(decryptedText == plainText);
	return 0;
}
