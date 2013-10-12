/****************************************************************************
Copyright (c) 2010-2012 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
package com.caesars.lib;
import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxGLSurfaceView;
import org.cocos2dx.plugin.PluginResultHelper;
import org.cocos2dx.plugin.PluginWrapper;

import com.caesars.nozomiAmz.R;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import android.os.Handler;
import android.os.Looper;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.KeyEvent;
import android.view.WindowManager;

public class CaesarsActivity extends Cocos2dxActivity{
	private static Cocos2dxActivity me = null;
	private static int notifyNum = 0;
	private static int deleteNum = 0;

	private static native void setDeviceId(String deviceId); 
	
	
	protected void onCreate(Bundle savedInstanceState){
		Log.e("COCOS2D_ACTIVITY", "me activity is:"+me);
		if(me!=null){
			finish();
			return;
		}
		super.onCreate(savedInstanceState);
		PluginWrapper.init(this); 
		me = this;
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

		TelephonyManager tm = (TelephonyManager) this.getSystemService(TELEPHONY_SERVICE);     
		setDeviceId(tm.getDeviceId());
		
		PluginWrapper.setGLSurfaceView(Cocos2dxGLSurfaceView.getInstance());
	}
	
	@Override
	public Cocos2dxGLSurfaceView onCreateView() {
    	return new LuaGLSurfaceView(this);
    }

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		//super.onActivityResult(requestCode, resultCode, data);
		PluginResultHelper.onActivityResult(requestCode, resultCode, data);
	}
	
	public static void openURL(String url) { 
        Intent i = new Intent(Intent.ACTION_VIEW);  
        i.setData(Uri.parse(url)); 
        me.startActivity(i);
    }
	
	public static void postNotification(final int duration, final String content)
	{
	}
	
	public static void clearLocalNotification()
	{
		/*
		deleteNum = notifyNum;
		String ns = Context.NOTIFICATION_SERVICE;
		NotificationManager mNotificationManager = (NotificationManager)me.getSystemService(ns);
		mNotificationManager.cancelAll();
		*/
	}
	
	public static void showAlert(String title, String content, int button1, String button1Text, int button2, String button2Text)
	{
		//new CSAlertView(me, title, content, button1, button1Text, button2, button2Text);
	}
}

class LuaGLSurfaceView extends Cocos2dxGLSurfaceView{
	
	public LuaGLSurfaceView(Context context){
		super(context);
	}

	@Override
	public boolean onKeyDown(final int pKeyCode, final KeyEvent pKeyEvent) {
    	// exit program when key back is entered
    	if (pKeyCode == KeyEvent.KEYCODE_BACK) {
    		Context me = this.getContext();

			Cocos2dxGLSurfaceView.getInstance().onPause();
			Cocos2dxGLSurfaceView.getInstance().onResume();
			/*
    		new CSAlertView(this.getContext(), me.getString(R.string.exit_title), 
    				me.getString(R.string.exit_content), 2, me.getString(R.string.exit_ok), 
    				1, me.getString(R.string.exit_cancel));
    		*/
    		//new com.android.game.api.api.DialogInterface((Activity)me, DialogType.EXITDIALOG);
    	}
        return super.onKeyDown(pKeyCode, pKeyEvent);
    }
}
