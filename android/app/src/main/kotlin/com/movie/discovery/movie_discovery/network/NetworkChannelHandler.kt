package com.movie.discovery.movie_discovery.network

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class NetworkChannelHandler : MethodChannel.MethodCallHandler {
    private val apiClient = ApiClient()
    private val scope = CoroutineScope(Dispatchers.Main)

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "request" -> handleRequest(call, result)
            else -> result.notImplemented()
        }
    }

    @Suppress("UNCHECKED_CAST")
    private fun handleRequest(call: MethodCall, result: MethodChannel.Result) {
        val baseUrl = call.argument<String>("baseUrl")
        val path = call.argument<String>("path")

        if (baseUrl.isNullOrEmpty()) {
            result.error("INVALID_ARGUMENTS", "baseUrl is required and cannot be empty", null)
            return
        }

        if (path.isNullOrEmpty()) {
            result.error("INVALID_ARGUMENTS", "path is required and cannot be empty", null)
            return
        }

        val method = call.argument<String>("method") ?: "GET"
        val queryParams = call.argument<Map<String, Any>>("queryParams")
        val headers = call.argument<Map<String, String>>("headers")

        scope.launch {
            try {
                val response = apiClient.request(
                    baseUrl = baseUrl,
                    path = path,
                    method = method,
                    queryParams = queryParams,
                    headers = headers
                )
                result.success(response)
            } catch (e: Exception) {
                result.error(
                    "NETWORK_ERROR",
                    e.message ?: "Unknown error",
                    null
                )
            }
        }
    }
}
