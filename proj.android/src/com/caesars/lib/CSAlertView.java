package com.caesars.lib;

import org.cocos2dx.plugin.PluginWrapper;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;

public class CSAlertView implements OnClickListener{
	private int[] button;
	public CSAlertView(Context context, String title, String content, int button1, String button1Text, int button2, String button2Text)
	{
		button = new int[2];
		button[0] = button1;
		button[1] = button2;
		final AlertDialog.Builder alertBuider = new AlertDialog.Builder(context)
		.setTitle(title).setMessage(content).setPositiveButton(button1Text, this);
		if(button2>0){
			alertBuider.setNegativeButton(button2Text, this);
		}

		PluginWrapper.runOnMainThread(new Runnable(){
			@Override
			public void run() {
				alertBuider.create().show();
			}
		});
	}
	@Override
	public void onClick(DialogInterface arg0, int arg1) {
		int type = button[-1-arg1];
		if(type==2){
			android.os.Process.killProcess(android.os.Process.myPid());
		}
	}
}
