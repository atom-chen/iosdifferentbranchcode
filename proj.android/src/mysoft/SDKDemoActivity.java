package mysoft;
import com.caesars.nozomiAmz.R;

import de.softgames.sdk.SoftgamesAbstractActivity;
import de.softgames.sdk.ui.SGAdView;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageButton;

public class SDKDemoActivity extends SoftgamesAbstractActivity {
	protected void onCreate(Bundle sb){
		super.onCreate(sb);
		Log.e("Softgame", "enter game!");
		setContentView(R.layout.testv);
		/*
		ImageButton sgButtonNoAds= (ImageButton)findViewById(de.softgames.sdk.R.id.sg_button_no_ads);
		
        sgButtonNoAds.setOnClickListener(new OnClickListener() {            
            @Override
            public void onClick(View v) {
            }
        });
        */
	}
	public void hideBannerAds(){
		runOnUiThread(new Runnable(){

			@Override
			public void run() {
				// TODO Auto-generated method stub
				//SGAdView sgView = (SGAdView)findViewById(de.softgames.sdk.R.id.sg);
				
			}
			
		});
	}
}
