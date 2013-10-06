package org.cocos2dx.plugin;

import java.util.Hashtable;

import mysoft.SDKDemoActivity;

import org.cocos2dx.plugin.InterfaceAds;
import org.cocos2dx.plugin.PluginWrapper;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageButton;

import de.softgames.sdk.R;
import de.softgames.sdk.ui.SGAdView;

public class MyAds implements InterfaceAds {
	private SGAdView sg;
	private Context mContext;
	
	public MyAds(Context c){
		mContext = c;
	}
	@Override
	public void configDeveloperInfo(Hashtable<String, String> devInfo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void showAds(int type, int sizeEnum, int pos) {
		// TODO Auto-generated method stub
		PluginWrapper.runOnMainThread(new Runnable(){

			@Override
			public void run() {
				// TODO Auto-generated method stub
				if(sg != null) {
					sg.setVisibility(View.VISIBLE);
					return;
				}
				sg = new SGAdView(mContext);
				ImageButton but = (ImageButton)sg.findViewById(R.id.sg_button_no_ads);
				but.setOnClickListener(new OnClickListener(){

					@Override
					public void onClick(View arg0) {
						sg.setVisibility(View.INVISIBLE);
					}
					
				});
				Activity act = (Activity)mContext;
				FrameLayout con = (FrameLayout)act.findViewById(android.R.id.content);
				ViewGroup.LayoutParams sgparam =
			            new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT,
			                                       ViewGroup.LayoutParams.WRAP_CONTENT);
				con.addView(sg, sgparam);
				/*
				Intent in = new Intent(mContext, SDKDemoActivity.class);
				mContext.startActivity(in);
				*/
			}
			
		});
	}

	@Override
	public void hideAds(int type) {
		// TODO Auto-generated method stub
		PluginWrapper.runOnMainThread(new Runnable(){

			@Override
			public void run() {
				// TODO Auto-generated method stub
				
				if(sg != null) {
					sg.setVisibility(View.GONE);
					sg = null;
				}
				
			}
			
		});
		
	}

	@Override
	public void spendPoints(int points) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setDebugMode(boolean debug) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getSDKVersion() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getPluginVersion() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
