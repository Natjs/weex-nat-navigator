package com.instapp.nat.weex;

import android.app.Activity;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by Acathur on 17/10/03.
 *  Copyright (c) 2017 Instapp. All rights reserved.
 */

public class CacheActivity {
    public static List<Activity> activityList = new LinkedList<Activity>();

    public CacheActivity() {
    }

    public static void addActivity(Activity activity) {
        if (!activityList.contains(activity)) {
            activityList.add(activity);
        }
    }

    public static void finishActivity() {
        for (Activity activity : activityList) {
            activity.finish();
        }
    }
    
    public static void finishActivityExceptRoot() {
        for (int i = 0; i < activityList.size(); i++) {
            if (i > 0) {
                activityList.get(i).finish();
            }
        }
    }

    public static void finishSingleActivity(Activity activity) {
        if (activity != null) {
            if (activityList.contains(activity)) {
                activityList.remove(activity);
            }
            activity.finish();
            activity = null;
        }
    }

    public static void finishSingleActivityByClass(Class<?> cls) {
        Activity tempActivity = null;
        for (Activity activity : activityList) {
            if (activity.getClass().equals(cls)) {
                tempActivity = activity;
            }
        }

        finishSingleActivity(tempActivity);
    }
}