package com.stevie.xmly;

import com.ximalaya.ting.android.opensdk.datatrasfer.CommonRequest;

/**
 * Author：Stevie.Chen Time：2020/5/27
 * Class Comment：
 */
public interface IRequestCallBack<T> extends CommonRequest.IRequestCallBack<T> {

    T success(String var1) throws Exception;
}
