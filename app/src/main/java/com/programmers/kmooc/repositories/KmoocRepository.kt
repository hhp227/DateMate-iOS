package com.programmers.kmooc.repositories

import android.util.Log
import com.programmers.kmooc.models.Lecture
import com.programmers.kmooc.models.LectureList
import com.programmers.kmooc.network.HttpClient
import com.programmers.kmooc.utils.DateUtil
import com.programmers.kmooc.utils.ExtensionUtil.map
import org.json.JSONObject
import java.util.*

class KmoocRepository {

    /**
     * 국가평생교육진흥원_K-MOOC_강좌정보API
     * https://www.data.go.kr/data/15042355/openapi.do
     */

    private val httpClient = HttpClient("http://apis.data.go.kr/B552881/kmooc")
    private val serviceKey =
        "S0Th%2BnglX8DlsHhvLC4wE85faAq7MK%2BmB3GkNX0i6BNBHbBgIb6JF1vXioR%2FbMuIRWLjFQun0mOdDqSX%2FxFdAQ%3D%3D"

    fun list(completed: (LectureList) -> Unit) {
        httpClient.getJson(
            "/courseList",
            mapOf("serviceKey" to serviceKey, "Mobile" to 1)
        ) { result ->
            result.onSuccess {
                try {
                    completed(parseLectureList(JSONObject(it)))
                } catch (e: Exception) {
                    Log.e(KmoocRepository::class.java.simpleName, e.message.toString())
                }
            }
        }
    }

    fun next(currentPage: LectureList, completed: (LectureList) -> Unit) {
        val nextPageUrl = currentPage.next
        httpClient.getJson(nextPageUrl, emptyMap()) { result ->
            result.onSuccess {
                completed(parseLectureList(JSONObject(it)))
            }
        }
    }

    fun detail(courseId: String, completed: (Lecture) -> Unit) {
        httpClient.getJson(
            "/courseDetail",
            mapOf("CourseId" to courseId, "serviceKey" to serviceKey)
        ) { result ->
            result.onSuccess {
                completed(parseLecture(JSONObject(it)))
            }
        }
    }

    private fun parseLectureList(jsonObject: JSONObject): LectureList {
        //TODO: JSONObject -> LectureList 를 구현하세요
        return try {
            jsonObject.getJSONObject("pagination").let { pagination ->
                LectureList(
                    count = pagination.getInt("count"),
                    numPages = pagination.getInt("num_pages"),
                    previous = pagination.getString("previous"),
                    next = pagination.getString("next"),
                    lectures = jsonObject.getJSONArray("results").map(::parseLecture)
                )
            }
        } catch (e: Exception) {
            LectureList.EMPTY
        }
    }

    private fun parseLecture(jsonObject: JSONObject): Lecture {
        //TODO: JSONObject -> Lecture 를 구현하세요
        return try {
            Lecture(
                id = jsonObject.getString("id"),
                number = jsonObject.getString("number"),
                name = jsonObject.getString("name"),
                classfyName = jsonObject.getString("classfy_name"),
                middleClassfyName = jsonObject.getString("middle_classfy_name"),
                courseImage = jsonObject.getJSONObject("media").getJSONObject("image").getString("small"),
                courseImageLarge = jsonObject.getJSONObject("media").getJSONObject("image").getString("large"),
                shortDescription = jsonObject.getString("short_description"),
                orgName = jsonObject.getString("org_name"),
                start = DateUtil.parseDate(jsonObject.getString("start")),
                end = DateUtil.parseDate(jsonObject.getString("end")),
                teachers = jsonObject.getString("teachers"),
                overview = jsonObject.getString("blocks_url")
            )
        } catch (e: Exception) {
            Lecture.EMPTY
        }
    }
}