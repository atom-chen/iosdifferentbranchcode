package org.cocos2dx.plugin;

import java.util.Hashtable;

import mysoft.MyMoreGames;
import mysoft.SDKDemoActivity;

import org.cocos2dx.plugin.InterfaceAds;
import org.cocos2dx.plugin.PluginWrapper;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.caesars.nozomiAmz.R;
import com.tapjoy.TapjoyConnect;

import de.softgames.sdk.ui.MoreGamesButton;
import de.softgames.sdk.ui.SGAdView;

public class MyAds implements InterfaceAds {
	private SGAdView sg;
	private Context mContext;
	private MoreGamesButton moregames;
	private RelativeLayout rl;
	private LinearLayout bottom;
	private static native void closeAds();
	
	public static String uid;
	public MyAds(Context c){
		mContext = c;
		/*
		moregame = new MoreGamesButton(mContext);
		*/
		
		
	}
	@Override
	public void configDeveloperInfo(Hashtable<String, String> devInfo) {
		// TODO Auto-generated method stub
		uid = devInfo.get("uid");
		TapjoyConnect.getTapjoyConnectInstance().setUserID(uid);
	}
	private void createLayout() {
		if(rl == null) {
			Activity act = (Activity)mContext;
			FrameLayout con = (FrameLayout)act.findViewById(android.R.id.content);
			/*
			ViewGroup.LayoutParams sgparam =
		            new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT,
		                                     ViewGroup.LayoutParams.WRAP_CONTENT);
		    */
			FrameLayout.LayoutParams fparam = new FrameLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT);
			fparam.gravity = Gravity.BOTTOM | Gravity.LEFT;
			
			rl = new RelativeLayout(mContext);
			con.addView(rl, fparam);
			
			LinearLayout up = new LinearLayout(mContext);
			rl.addView(up);
			
			bottom = new LinearLayout(mContext);
			RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
			lp.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
			bottom.setOrientation(LinearLayout.VERTICAL);
			
			rl.addView(bottom, lp);
			
		}
	}
	@Override
	public void showAds(int type, int sizeEnum, int pos) {
		// TODO Auto-generated method stub
		PluginWrapper.runOnMainThread(new Runnable(){

			@Override
			public void run() {
				createLayout();
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
						//sg.setVisibility(View.INVISIBLE);
						PluginWrapper.runOnGLThread(new Runnable(){

							@Override
							public void run() {
								// TODO Auto-generated method stub
								closeAds();
							}
							
						});
					}
					
				});
				//Activity act = (Activity)mContext;
				//FrameLayout con = (FrameLayout)act.findViewById(android.R.id.content);
				LinearLayout.LayoutParams sgparam =
			            new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
				//con.addView(sg, sgparam);
				sgparam.weight = 1;
				sgparam.setMargins(5, 5, 5, 5);
				bottom.addView(sg, sgparam);
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
				//createLayout();
				
				if(sg != null) {
					sg.setVisibility(View.INVISIBLE);
					//sg = null;
				}
				
			}
			
		});
		
	}
	//lua 层召唤 moregames button
	@Override
	public void spendPoints(int points) {
		final int v = points;
		PluginWrapper.runOnMainThread(new Runnable() {
			@Override
			public void run() {
				
				createLayout();
				// TODO Auto-generated method stub
				//Intent inte = new Intent(mContext, MyMoreGames.class);
				//mContext.startActivity(inte);
				if(v == 0) {
					if(moregames == null) {
						//Activity act = (Activity)mContext;
						//FrameLayout con = (FrameLayout)act.findViewById(android.R.id.content);
						LinearLayout.LayoutParams sgparam =
					            new LinearLayout.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT,
					                                       ViewGroup.LayoutParams.WRAP_CONTENT);
						sgparam.weight = 1;
						sgparam.setMargins(5, 5, 5, 5);
						moregames = new MoreGamesButton(mContext);
						//con.addView(moregames, sgparam);
						bottom.addView(moregames, sgparam);
					} else {
						moregames.setVisibility(View.VISIBLE);
					}
					
					//LayoutInflater inflater = (LayoutInflater) act
				    //            .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
				    //    inflater.inflate(de.softgames.sdk.R.layout.sg_button_more_games_layout, con, true);
				} else if(v == 1){
					if(moregames != null) {
						moregames.setVisibility(View.INVISIBLE);
						//moregames = null;
					}
				//显示推广墙
				} else if(v == 2){
					TapjoyConnect.getTapjoyConnectInstance().showOffers();
				//隐藏推广墙 tapjoy
				} else if(v == 3) {
					
				}
			}
		
		});
		
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
