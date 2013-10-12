package com.liyong.iap;

import org.cocos2dx.plugin.IAPWrapper;
import org.cocos2dx.plugin.PluginResultHelper;
import com.caesars.nozomiAmz.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.amazon.inapp.purchasing.BasePurchasingObserver;
import com.amazon.inapp.purchasing.GetUserIdResponse;
import com.amazon.inapp.purchasing.ItemDataResponse;
import com.amazon.inapp.purchasing.PurchaseResponse;
import com.amazon.inapp.purchasing.PurchaseResponse.PurchaseRequestStatus;
import com.amazon.inapp.purchasing.PurchaseUpdatesResponse;
import com.caesars.nozomi.NozomiActivity;

public class AmazonIAP extends BasePurchasingObserver{
	//private final NozomiActivity act;
	private Context mContext;
	public static int reqId;
	public static AmazonIAP am;
	
	public AmazonIAP(Context arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
		Log.e("IAP", "Amazon IAP");
		//this.act = arg0;
		mContext = arg0;
		am = this;
	}
	@Override 
	public void onItemDataResponse(ItemDataResponse itemDataResponse) {
		Log.e("Amazon IAP", "item "+itemDataResponse);
	}
	
	@Override 
	public void onPurchaseResponse(PurchaseResponse purchaseResponse) {
		Log.e("Amazon IAP", "purchase "+purchaseResponse);
		PurchaseRequestStatus status = purchaseResponse.getPurchaseRequestStatus();
		Intent data = new Intent();
		if(PurchaseRequestStatus.SUCCESSFUL == status) {
			PluginResultHelper.onActivityResult(reqId, Activity.RESULT_OK, data);
		}else {
			PluginResultHelper.onActivityResult(reqId, Activity.RESULT_CANCELED, data);
		}
	}
	@Override
	public void onGetUserIdResponse(GetUserIdResponse uid) {
		
	}
	@Override
	public void onPurchaseUpdatesResponse(PurchaseUpdatesResponse arg0) {
		
	}
	@Override
	public void onSdkAvailable(boolean arg0) {
		
	}
}