package com.caesars.nozomi;

import android.os.Bundle;

import com.adeven.adjustio.AdjustIo;
import com.caesars.lib.CaesarsActivity;

import com.liyong.tearcloth.R;

public class NozomiActivity extends CaesarsActivity {

	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
	}
	
    static {
        System.loadLibrary("cocos2dlua");
    }
    @Override
    protected void onPause() {
        super.onPause();
        AdjustIo.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        AdjustIo.onResume(getResources().getString(R.string.sg_adjust_token), this);
    }
}
