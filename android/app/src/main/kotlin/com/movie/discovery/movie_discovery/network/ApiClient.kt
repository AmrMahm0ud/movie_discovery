package com.movie.discovery.movie_discovery.network

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.HttpUrl.Companion.toHttpUrl
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.logging.HttpLoggingInterceptor
import java.util.concurrent.TimeUnit

class ApiClient {
    private val gson = Gson()

    private val client: OkHttpClient by lazy {
        val logging = HttpLoggingInterceptor().apply {
            level = HttpLoggingInterceptor.Level.BODY
        }
        OkHttpClient.Builder()
            .addInterceptor(logging)
            .build()
    }

    suspend fun request(
        baseUrl: String,
        path: String,
        method: String,
        queryParams: Map<String, Any>?,
        headers: Map<String, String>?
    ): Map<String, Any?> {
        return withContext(Dispatchers.IO) {
            try {
                val urlBuilder = "$baseUrl$path".toHttpUrl().newBuilder()
                queryParams?.forEach { (key, value) ->
                    urlBuilder.addQueryParameter(key, value.toString())
                }

                val requestBuilder = Request.Builder()
                    .url(urlBuilder.build())
                    .get()

                headers?.forEach { (key, value) ->
                    requestBuilder.addHeader(key, value)
                }

                val response = client.newCall(requestBuilder.build()).execute()
                val body = response.body?.string()

                if (response.isSuccessful && body != null) {
                    val type = object : TypeToken<Map<String, Any>>() {}.type
                    val data: Map<String, Any> = gson.fromJson(body, type)
                    mapOf(
                        "statusCode" to response.code,
                        "data" to data,
                        "error" to null
                    )
                } else {
                    mapOf(
                        "statusCode" to response.code,
                        "data" to null,
                        "error" to (body ?: "Request failed with status ${response.code}")
                    )
                }
            } catch (e: Exception) {
                mapOf(
                    "statusCode" to 0,
                    "data" to null,
                    "error" to (e.message ?: "Unknown error occurred")
                )
            }
        }
    }
}
