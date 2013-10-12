package org.cocos2dx.plugin;

import java.util.HashSet;
import java.util.Hashtable;
import java.util.Set;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.amazon.inapp.purchasing.BasePurchasingObserver;
import com.amazon.inapp.purchasing.PurchasingManager;
import com.liyong.iap.AmazonIAP;

public class Amazon  implements InterfaceIAP{
	private static InterfaceIAP mAdapter = null;
	private static Activity mContext;
	public Amazon(Context context){
		mAdapter = this;
		mContext = (Activity)context;
	}
	private PluginResultHelper.InterfacePluginResult handler = new PluginResultHelper.InterfacePluginResult() {
		
		@Override
		public void onActivityResult(int requestCode, int resultCode, Intent data) {
			Log.d("payment Example", " "+Activity.RESULT_OK+" "+Activity.RESULT_CANCELED);
			if(resultCode == Activity.RESULT_OK) {
				IAPWrapper.onPayResult(mAdapter, IAPWrapper.PAYRESULT_SUCCESS, "Successful");
			} else if(resultCode == Activity.RESULT_CANCELED) {
				if(data!=null && !data.getBooleanExtra("available", true))
				{
					AlertDialog alert = new AlertDialog.Builder(mContext)
					.setTitle(R.string.pay_not_available_title)
					.setMessage(R.string.pay_not_available_message)
					.setNegativeButton(R.string.pay_not_available_button, null)
					.create();
					alert.show();
					IAPWrapper.onPayResult(mAdapter, IAPWrapper.PAYRESULT_FAIL, "Amazon not available!");
				}
				else
				{
					IAPWrapper.onPayResult(mAdapter, IAPWrapper.PAYRESULT_CANCEL, "Cancel!");
					Log.i("Example", "user canceled");
				}
			} else{
				IAPWrapper.onPayResult(mAdapter, IAPWrapper.PAYRESULT_FAIL, "Fail  "+resultCode);
			}
		}
	};
	private Hashtable<String, String> productTable;
	
	@Override
	public void configDeveloperInfo(Hashtable<String, String> cpInfo) {
		// TODO Auto-generated method stub
		productTable = new Hashtable<String, String>(cpInfo);
	}

	@Override
	public void payForProduct(Hashtable<String, String> cpInfo) {
		// TODO Auto-generated method stub
		Set<String> s = new HashSet<String>();
		s.add(productTable.get(cpInfo.get("productName")));
		PurchasingManager.initiateItemDataRequest(s);
		int requestCode = PluginResultHelper.registerRequestCode(handler, 9);
		AmazonIAP.reqId = requestCode;
		String requestId = PurchasingManager.initiatePurchaseRequest(productTable.get(cpInfo.get("productName")));
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
