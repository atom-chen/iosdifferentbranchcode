package com.caesars.nozomi;

import android.os.Bundle;

import com.adeven.adjustio.AdjustIo;
import com.amazon.inapp.purchasing.PurchasingManager;
import com.caesars.lib.CaesarsActivity;

import com.liyong.iap.AmazonIAP;
import com.caesars.nozomiAmz.R;

public class NozomiActivity extends CaesarsActivity {
	AmazonIAP amazon;
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
	}
	
    static {
        System.loadLibrary("cocos2dlua");
    }
    @Override 
    protected void onStart() {
    	super.onStart();
    	amazon = new AmazonIAP(this);
    	PurchasingManager.registerObserver(amazon);
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
