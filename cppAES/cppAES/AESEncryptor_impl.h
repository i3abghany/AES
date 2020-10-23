using StrCIter = std::string::const_iterator;

template <size_t KeySize>
AESEncryptor<KeySize>::AESEncryptor()
{
	this->data = std::vector<std::string>{};
}

template <size_t KeySize>
AESEncryptor<KeySize>::AESEncryptor(const std::string& inputData)
{
	this->numBlocks = (inputData.size() / N) + (inputData.size() % N ? 1 : 0);
	this->data.resize(this->numBlocks, std::string(N, '\0'));
	SplitData(inputData);
	PadBlock(this->numBlocks - 1);
}

template <size_t KeySize>
void AESEncryptor<KeySize>::SplitData(const std::string& inputData)
{
	for (int i = 0; i < this->numBlocks; i++)
	{
		auto firstIter = std::begin(inputData) + (i * N);
		auto lastIter = (i == this->numBlocks - 1) ?
			std::end(inputData) :
			std::begin(inputData) + ((1 + i) * N);

		std::copy(firstIter, lastIter, std::begin(this->data[i]));
	}
}

template <size_t KeySize>
size_t AESEncryptor<KeySize>::blocks() const
{
	return this->numBlocks;
}

template <size_t KeySize>
std::string_view AESEncryptor<KeySize>::GetBlock(size_t idx) const
{
	if (idx >= numBlocks)
	{
		throw std::invalid_argument("Block index is not valid.\n");
	}
	return this->data[idx];
}

template<size_t KeySize>
void AESEncryptor<KeySize>::PadBlock(size_t idx)
{
	if (this->data[idx].size() == N)
		return;

	this->data[idx].resize(N);
}

template<size_t KeySize>
void AESEncryptor<KeySize>::load(const std::string& x)
{
	*this = AESEncryptor{ x };
}