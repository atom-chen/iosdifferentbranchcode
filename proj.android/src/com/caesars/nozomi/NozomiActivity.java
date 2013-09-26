package com.caesars.nozomi;

import android.os.Bundle;

import com.caesars.lib.CaesarsActivity;

public class NozomiActivity extends CaesarsActivity {

	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
	}
	
    static {
        System.loadLibrary("cocos2dlua");
    }
}
