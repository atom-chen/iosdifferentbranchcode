package com.caesars.nozomi;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.widget.Button;
import android.widget.FrameLayout;

import com.tapjoy.TapjoyConnect;

import com.adeven.adjustio.AdjustIo;
import com.amazon.inapp.purchasing.PurchasingManager;
import com.caesars.lib.CaesarsActivity;

import com.liyong.iap.AmazonIAP;
import com.caesars.nozomiAmz.R;

public class NozomiActivity extends CaesarsActivity {
	AmazonIAP amazon;
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		//run on UI
		TapjoyConnect.requestTapjoyConnect(this, "916fda06-a238-4541-829a-c055e6a8a2bc", "7UICyQW1iI8JHX8D72m9");
		//TapjoyConnect.getTapjoyConnectInstance().showOffers();
		
		FrameLayout con = (FrameLayout)this.findViewById(android.R.id.content);
		Button but = new Button(this);
		FrameLayout.LayoutParams fparam = new FrameLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT);
		fparam.gravity = Gravity.TOP | Gravity.LEFT;
		
		
		con.addView(but, fparam);
		
		
		final Activity temp = this;
		but.setOnClickListener(new OnClickListener(){

			@Override
			public void onClick(View arg0) {
				android.content.DialogInterface.OnClickListener handler = new android.content.DialogInterface.OnClickListener(){

					@Override
					public void onClick(DialogInterface arg0, int arg1) {
						// TODO Auto-generated method stub
						Log.e("Test", "onClicked");
					}};
				// TODO Auto-generated method stub
				AlertDialog alert = new AlertDialog.Builder(temp)
				.setTitle("购买水晶")
				.setItems(new String[]{"google wallet", "paypal"}, handler )
				.setNegativeButton("cancel", handler)
				.create();
				alert.show();
				
			}
			
		});
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
        //AdjustIo.onPause();
        TapjoyConnect.getTapjoyConnectInstance().appPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        //AdjustIo.onResume(getResources().getString(R.string.sg_adjust_token), this);
        Log.e("TapJoy", "resume tapjoy");
        TapjoyConnect.getTapjoyConnectInstance().appResume();
    }
}
