package com.instapp.nat.weex;

import android.app.Activity;

import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;
import com.taobao.weex.common.WXModule;

import com.instapp.nat.weex.CacheActivity;

/**
 * Created by Acathur on 17/10/10.
 *  Copyright (c) 2017 Instapp. All rights reserved.
 */

public class Navigator extends WXModule {

    public static final String MSG_SUCCESS = "WX_SUCCESS";
    public static final String MSG_FAILED = "WX_FAILED";

    @JSMethod(uiThread = true)
    public void popToRoot(String param, JSCallback jsCallback) {
        if (mWXSDKInstance.getContext() instanceof Activity) {
            CacheActivity.finishActivityExceptRoot();
            if (jsCallback != null) {
                jsCallback.invoke(MSG_SUCCESS);
            }
        }
    }
}
