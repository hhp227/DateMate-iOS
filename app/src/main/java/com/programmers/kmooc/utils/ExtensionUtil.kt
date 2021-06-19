package com.programmers.kmooc.utils

import org.json.JSONArray
import org.json.JSONObject

object ExtensionUtil {
    internal inline fun <reified T> JSONArray.map(transform: (JSONObject) -> T): List<T> {
        return List(this.length()) { i ->
            transform(getJSONObject(i))
        }
    }
}