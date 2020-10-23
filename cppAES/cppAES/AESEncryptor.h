#pragma once

#include <vector>
#include <string>
#include <iterator>
#include <string_view>

template <size_t KeySize = 16U>
class AESEncryptor
{
private:
	using StrCIter = std::string::const_iterator;
	static constexpr size_t N = 128U;

public:
	AESEncryptor();
	AESEncryptor(const std::string& data);
	size_t blocks() const;
	std::string_view GetBlock(size_t) const;
	void load(const std::string&);

private:
	void SplitData(const std::string&);
	void PadBlock(size_t);

private:
	std::vector<std::string> data; // data stored in chars (bytes).
	size_t numBlocks;
};

#include "AESEncryptor_impl.h"