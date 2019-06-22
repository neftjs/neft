package io.neft.extensions.storage_extension

import io.neft.client.NativeBinding

object StorageExtension {
    private val BINDING = NativeBinding("Storage")

    private fun createCallback(uid: String): FileStorage.Callback {
        return object : FileStorage.Callback() {
            override fun handle(error: Exception?, result: String) {
                val errMsg = error?.message
                BINDING.pushEvent("response", uid, errMsg, result)
            }
        }
    }

    @JvmStatic
    fun register() {
        val fileStorage = FileStorage()

        BINDING
                .onCall("get") { args ->
                    val uid = args[0] as String
                    val key = args[1] as String
                    fileStorage.get(key, createCallback(uid))
                }
                .onCall("set") { args ->
                    val uid = args[0] as String
                    val key = args[1] as String
                    val value = args[2] as String
                    fileStorage.set(key, value, createCallback(uid))
                }
                .onCall("remove") { args ->
                    val uid = args[0] as String
                    val key = args[1] as String
                    fileStorage.remove(key, createCallback(uid))
                }
    }
}
