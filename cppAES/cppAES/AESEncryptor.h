#pragma once

#include <vector>
#include <string>
#include <iterator>
#include <string_view>
#include <fstream>

template <size_t KeySize = 16U>
class AESEncryptor
{
	static_assert(KeySize == 16U || KeySize == 24U || KeySize == 32U, "Only 16-, 24-, and 32-byte keys are allowed.");
private:
	using StrCIter = std::string::const_iterator;
	static constexpr size_t N = 128U;  // Block Size.

public:
	AESEncryptor();
	AESEncryptor(const std::string& data);
	size_t blocks() const;
	std::string_view GetBlock(size_t) const;

	void load(const std::string&);
	void loadFile(const std::string&);

private:
	void SplitData(const std::string&);

private:
	std::vector<std::string> data; // data stored in chars (bytes).
	size_t numBlocks;
};

#include "AESEncryptor_impl.h"