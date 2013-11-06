package mysoft;

import com.caesars.nozomi.NozomiActivity;
import com.caesars.nozomiAmz.R;

import de.softgames.sdk.util.SGSettings;
import android.app.Application;

public class SoftgamesApplication extends Application {

    @Override
    public void onCreate() {

        // Initializes the GoogleAnalytics tracker object
        SGSettings.initGAnalyticsTracker(getApplicationContext());

        /*
         * Init your app's entry point activity. This is the activity that you
         * want to be called when the app starts
         */
        SGSettings.setLauncherActivity(NozomiActivity.class);
        //SGSettings.setLauncherActivity(SDKDemoActivity.class);

        /*
         * This method sets the teaser image that is going to be
         * displayed in the cross-promotion page. This image is related to your
         * game
         */
        SGSettings.setTeaserImage(getResources().getDrawable(
                R.drawable.icon540));

        /*
         * Set the name of the game.
         */
        SGSettings.setGameName(getResources().getString(R.string.app_name));
    }
}
