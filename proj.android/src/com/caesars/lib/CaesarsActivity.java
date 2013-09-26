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
import org.cocos2dx.plugin.PluginWrapper;

import com.caesars.nozomi.R;

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
import android.view.KeyEvent;
import android.view.WindowManager;

public class CaesarsActivity extends Cocos2dxActivity{
	private static Cocos2dxActivity me = null;
	private static int notifyNum = 0;
	private static int deleteNum = 0;

	private static native void setDeviceId(String deviceId); 
	
	
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		PluginWrapper.init(this); 
		me = this;
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

		TelephonyManager tm = (TelephonyManager) this.getSystemService(TELEPHONY_SERVICE);     
		setDeviceId(tm.getDeviceId());
		
		PluginWrapper.setGLSurfaceView(Cocos2dxGLSurfaceView.getInstance());
	}
	
	public static void openURL(String url) { 
        Intent i = new Intent(Intent.ACTION_VIEW);  
        i.setData(Uri.parse(url)); 
        me.startActivity(i);
    }
	
	public static void postNotification(final int duration, final String content)
	{
		/*
		final int notifyId = ++notifyNum;
		new Handler(Looper.getMainLooper()).postDelayed(new Runnable(){

			@Override
			public void run() {
				if(notifyId<=deleteNum)
					return;
				String ns = Context.NOTIFICATION_SERVICE;
				NotificationManager mNotificationManager = (NotificationManager)me.getSystemService(ns);
				int icon = R.drawable.icon;

				long when = System.currentTimeMillis() + duration*1000; //֪ͨ�����ʱ�䣬����֪ͨ��Ϣ����ʾ
				Notification notification = new Notification(icon, content, when);
				notification.number = notifyId-deleteNum;
				
				Intent notificationIntent = new Intent(me,me.getClass()); 
				PendingIntent contentIntent = PendingIntent.getActivity(me,0,notificationIntent,0);
				notification.setLatestEventInfo(me.getApplicationContext(),me.getApplicationContext().getPackageManager().getApplicationLabel(me.getApplicationInfo()), content, contentIntent);
				mNotificationManager.notify(notifyId-deleteNum, notification);
			}
		}, duration*1000);
		*/
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
	
	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		//if(requestCode == SocialFacebook.REQUEST_FACEBOOK_CODE){
		//	SocialFacebook.onActivityResult(this, requestCode, resultCode, data);
		//}
	}
	
	
	public Cocos2dxGLSurfaceView onCreateGLSurfaceView() {
    	return new LuaGLSurfaceView(this);
    }
}

class LuaGLSurfaceView extends Cocos2dxGLSurfaceView{
	
	public LuaGLSurfaceView(Context context){
		super(context);
	}
	
	public boolean onKeyDown(int keyCode, KeyEvent event) {
    	// exit program when key back is entered
    	if (keyCode == KeyEvent.KEYCODE_BACK) {
    		android.os.Process.killProcess(android.os.Process.myPid());
    	}
        return super.onKeyDown(keyCode, event);
    }
}
