#ifndef __CAESARS_CONFIGLOADER_H__
#define __CAESARS_CONFIGLOADER_H__

class ConfigLoader
{
public:
	ConfigLoader();
	~ConfigLoader();

	void loadConfig(const char* filename);
};

#endif //__CAESARS_CONFIGLOADER_H__