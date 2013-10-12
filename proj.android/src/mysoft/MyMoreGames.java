package mysoft;

import com.caesars.nozomiAmz.R;
import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.Tracker;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import de.softgames.sdk.OpenxAdView;


import de.softgames.sdk.SoftgamesAbstractActivity;
import de.softgames.sdk.SoftgamesActivity;
import de.softgames.sdk.util.NetworkUtilities;
import de.softgames.sdk.util.SGSettings;

public class MyMoreGames extends SoftgamesAbstractActivity implements OnClickListener{
	private LinearLayout crossPromotionLayout;
	private OpenxAdView crossPromoAdView;
	private Tracker mTracker;
	@Override
    protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		//setContentView(de.softgames.sdk.R.layout.sg_button_more_games_layout);
		setContentView(R.layout.testv);
		FrameLayout ll = (FrameLayout)this.findViewById(android.R.id.content);
		 LayoutInflater inflater = (LayoutInflater) this
	                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	        inflater.inflate(de.softgames.sdk.R.layout.sg_button_more_games_layout, ll, true);
		
		/*
		GoogleAnalytics mInstance = GoogleAnalytics.getInstance(this);
		mTracker = mInstance.getDefaultTracker();
		crossPromoAdView = new OpenxAdView(this);
		showCrosspromotion();
		*/
	}
	private void showCrosspromotion() {
        crossPromoAdView.load();
            try {
                crossPromoAdView.load();
                mTracker.sendView("/CrossPromotionPage");

            } catch (Exception e) {
                
            }

    }
	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		
	}

}
